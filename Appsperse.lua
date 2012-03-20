module(..., package.seeall)
local native = require("native")
local system = require("system")
local network = require("network")
local io = require("io")
local app_key= "982b750fcc574d02bcdbe3eb822c408d"
local deviceID = system.getInfo( "deviceID" )
local model = system.getInfo( "model" )
local demo = "n"
local o = "landscape"
local baseURL = "http://api.appsperse.com/api?"
local receiptURL = "http://api.appsperse.com/receipt"
local queryListener

local function purchaseNetworkListener( event )
	
end

local function adShown( event )
	local customEvent = {hasAd=true, eventType="adShowing"}
	queryListener(customEvent)
end

local function startAdShowing( event )
	local customEvent = {hasAd=true, eventType="adStartShowing"}
	queryListener(customEvent)
end

local function networkListener( event )
	local customEvent = {hasAd=false, eventType="didReceiveResponse"}
	--queryListener(customEvent)
	if ( event.isError ) then
		customEvent = {hasAd=false, eventType="responseError"}
		--queryListener(customEvent)
	else
		local customEvent
		if nil ~= string.find( event.response, "Error" ) then
			customEvent = {hasAd=false, eventType="responseError"}
			queryListener(customEvent)
			return
		end
		customEvent = {hasAd=true, eventType="adServed"}
		--queryListener(customEvent)
		local path = system.pathForFile( "ad.html", system.DocumentsDirectory )
		fh = io.open( path, "w" )
		fh:write(event.response)
		fh:flush()
		io.close()
		
	end
end

local function networkListenerPortrait( event )
	local customEvent = {hasAd=false, eventType="didReceiveResponse"}
	queryListener(customEvent)
	if ( event.isError ) then
		customEvent = {hasAd=false, eventType="responseError"}
		queryListener(customEvent)
	else
		local customEvent
		if nil ~= string.find( event.response, "Error" ) then
			customEvent = {hasAd=false, eventType="responseError"}
			queryListener(customEvent)
			return
		end
		customEvent = {hasAd=true, eventType="adServed"}
		queryListener(customEvent)
		local path = system.pathForFile( "ad_portrait.html", system.DocumentsDirectory )
		fh = io.open( path, "w" )
		fh:write(event.response)
		fh:flush()
		io.close()
		
	end
end

local function getAdRemote()
	local customEvent = {hasAd=false, eventType="willRequestAd"}
	queryListener(customEvent)
	network.request( baseURL.."device_type="..model.."&device_mac="..deviceID.."&app_key="..app_key.."&promotion_type=interstitial&v=1.0b3&device_app_uuid="..deviceID.."&screen_orientation=landscape&country=US&language=en&method=htmlpromotion&device_bundle_id=com.appsperse.Corona&demo_mode="..demo.."&device_id="..deviceID.."&", "GET", networkListener )
	network.request( baseURL.."device_type="..model.."&device_mac="..deviceID.."&app_key="..app_key.."&promotion_type=interstitial&v=1.0b3&device_app_uuid="..deviceID.."&screen_orientation=portrait&country=US&language=en&method=htmlpromotion&device_bundle_id=com.appsperse.Corona&demo_mode="..demo.."&device_id="..deviceID.."&", "GET", networkListenerPortrait )
end

local function listener( event )
        local url = event.url
		local customEvent
		if event.errorCode then
				customEvent = {hasAd=false, eventType="adShowingError"}
				queryListener(customEvent)
				return false
		end
        if nil ~= string.find( url, "appsperse.com/api" ) then
				customEvent = {hasAd=true, eventType="adTap"}
				queryListener(customEvent)
				system.openURL(url)
				return false
        end
		if nil ~= string.find( url, "appsperse.close" ) then
				customEvent = {hasAd=true, eventType="adClose"}
				queryListener(customEvent)
                return false
        end
		getAdRemote()
		return true
end

function init(appKey, queryAdListner)
	app_key = appKey
	queryListener = queryAdListner
	getAdRemote()
end

local function orientationChange(event)
	native.cancelWebPopup()
end

Runtime:addEventListener( "orientation", orientationChange )

function show()
		native.cancelWebPopup()
		xa = display.screenOriginX
		ya = display.screenOriginY
		ww = display.viewableContentWidth
		wh = display.viewableContentHeight
		local options = { hasBackground=false, baseUrl=system.DocumentsDirectory, urlRequest=listener }
		if nil ~= string.find(system.orientation, "portrait") then
			native.showWebPopup( xa, ya, ww, wh, 
			"ad_portrait.html", 
			options)
		else
			native.showWebPopup( xa, ya, ww, wh, 
			"ad.html", 
			options)
		end
end

function trackPurchase(transaction, product)
		local price = product.price
		local priceLocale = product.localizedPrice
		transactionID = transaction.identifier
		network.request( baseURL.."price="..price.."&price_locale="..priceLocale.."&transaction_id="..transactionID.."&device_type="..model.."&device_mac="..deviceID.."&app_key="..app_key.."&v=1.0b3&device_app_uuid="..deviceID.."&screen_orientation="..o.."&country=US&language=en&method=purchase&device_bundle_id=com.appsperse.Corona&demo_mode="..demo.."&device_id="..deviceID.."&", "GET", purchaseNetworkListener )
		local params = {}
		params.body = transaction.receipt
		network.request( receiptURL, "POST", purchaseNetworkListener, params)
end