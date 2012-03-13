module(..., package.seeall)
local native = require("native")
local system = require("system")
local network = require("network")
local io = require("io")
local app_key= "577951021d0143c09d46696e5282e947"
local deviceID = system.getInfo( "deviceID" )
local model = system.getInfo( "model" )
local demo = "n"
local o = "landscape"
local baseURL = "http://staging.appsperse.com/api?"
local receiptURL = "http://staging.appsperse.com/validatereceipt"
local queryListener
local lastTransaction
local webView

local function purchaseNetworkListener( event )
	
end

function productCallback( event )
				price = event.products[0].price
				priceLocale = event.products[0].localizedPrice
				transactionID = lastTransaction.identifier
				network.request( baseURL.."price="..price.."&price_locale="..priceLocale.."&transaction_id="..transactionID.."&device_type="..model.."&device_mac="..deviceID.."&app_key="..app_key.."&v=1.0b3&device_app_uuid="..deviceID.."&screen_orientation="..o.."&country=US&language=en&method=purchase&device_bundle_id=com.appsperse.Corona&demo_mode="..demo.."&device_id="..deviceID.."&", "GET", purchaseNetworkListener )
				local params = {}
				params.body = lastTransaction.receipt
				network.request( receiptURL, "POST", purchaseNetworkListener, params)
				lastTransaction = nil		
end

local function adShown( event )
	local customEvent = {hasAd=true, eventType="adShowing"}
	queryListener(customEvent)
end

local function startAdShowing( event )
	local customEvent = {hasAd=true, eventType="adStartShowing"}
	queryListener(customEvent)
end

local function listener( event )
        local url = event.url
		local customEvent
		if event.errorCode then
		        native.showAlert( "Error!", event.errorMessage, { "OK" } )
				ucstomEvent = {hasAd=false, eventType="error"}
				queryListener(customEvent)
				webView:removeSelf()
				webView = nil
				return
		end
        if nil ~= string.find( url, "appsperse.com/api" ) then
				customEvent = {hasAd=true, eventType="adTap"}
				queryListener(customEvent)
				system.openURL(url)
				return
        end
		if nil ~= string.find( url, "appsperse.close" ) then
				customEvent = {hasAd=true, eventType="adClose"}
				queryListener(customEvent)
				webView:removeSelf()
				webView = nil
                return
        end
		transition.to( webView, { time=1000, alpha=1, delay=1000 ,onComplete=adShown, onStart=startAdShowing } )
end

local function networkListener( event )
	if ( event.isError ) then
		customEvent = {hasAd=false, eventType="queryResponse"}
		queryListener(customEvent)
	else
		local customEvent
		if nil ~= string.find( event.response, "Error" ) then
			customEvent = {hasAd=false, eventType="queryResponse"}
			queryListener(customEvent)
			return
		end
		customEvent = {hasAd=true, eventType="queryResponse"}
		queryListener(customEvent)
		local path = system.pathForFile( "ad.html", system.DocumentsDirectory )
		fh = io.open( path, "w" )
		fh:write(event.response)
		fh:flush()
		io.close()

		xa = 0
		ya = 0
		ww = 480
		wh = 320
		if nil ~= string.find(system.orientation, "portrait") then
			xa = 0
			ya = 0
			ww = 320
			wh = 480
		end
		webView = native.newWebView( 0, 0, 480, 320 )
		webView.hasBackground = false
		webView.alpha = 0
		webView:request( "ad.html", system.DocumentsDirectory )
		webView:addEventListener( "urlRequest", listener )
	end
end

function init(appKey, queryAdListner)
	app_key = appKey
	queryListener = queryAdListner
end

function show()
	o = "landscape"
	if nil ~= string.find(system.orientation, "landscape") then
		o = "landscape"
	end
	if nil ~= string.find(system.orientation, "portrait") then
		o = "portrait"
	end
	print(system.orientation)
	--o = "landscape"
	network.request( baseURL.."device_type="..model.."&device_mac="..deviceID.."&app_key="..app_key.."&promotion_type=interstitial&v=1.0b3&device_app_uuid="..deviceID.."&screen_orientation="..o.."&country=US&language=en&method=htmlpromotion&device_bundle_id=com.appsperse.Corona&demo_mode="..demo.."&device_id="..deviceID.."&", "GET", networkListener )
end

function trackPurchase(transaction, productIdentifier)
	lastTransaction = transaction
	store.loadProducts( {productIdentifier}, productCallback )	
end