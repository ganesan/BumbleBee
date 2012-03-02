module(..., package.seeall)
local native = require("native")
local system = require("system")
local network = require("network")
local io = require("io")
local app_key= "174b7a57d0a945a398a44eb9c550f404"
local deviceID = system.getInfo( "deviceID" )
local model = system.getInfo( "model" )
local demo = "y"
local o = "landscape"
local baseURL = "http://dev.appsperse.com/api?"
local receiptURL = "http://dev.appsperse.com/validatereceipt"
local queryListener
local lastTransaction

local function purchaseNetworkListener( event )
	
end

function productCallback( event )
				price = event.products[0].price
				priceLocale = event.products[0].localizedPrice
				transactionID = lastTransaction.identifier
				network.request( baseURL.."api?price="..price.."&price_locale="..priceLocale.."&transaction_id="..transactionID.."&device_type="..model.."&device_mac="..deviceID.."&app_key="..app_key.."&v=1.0b3&device_app_uuid="..deviceID.."&screen_orientation="..o.."&country=US&language=en&method=purchase&device_bundle_id=com.appsperse.Corona&demo_mode="..demo.."&device_id="..deviceID.."&", "GET", purchaseNetworkListener )
				local params = {}
				params.body = lastTransaction.receipt
				network.request( receiptURL, "POST", purchaseNetworkListener, params)
				lastTransaction = nil		
end

local function listener( event )
        local url = event.url
		print(url)
		if nil ~= string.find( url, "ad.html" ) then
			return true
		end
        if nil ~= string.find( url, "appsperse.com/api" ) then
				customEvent = {hasAd=true, eventType="tapAd"}
				queryListener(customEvent)
        end
		if nil ~= string.find( url, "appsperse.close" ) then
				customEvent = {hasAd=true, eventType="closeAd"}
				queryListener(customEvent)
                return false
        end
 		system.openURL(url)
        return false
end

local function networkListener( event )
        if ( event.isError ) then
                print( "Network error!")
        else
				native.setActivityIndicator( false )
				local customEvent
				if nil ~= string.find( event.response, "ERROR" ) then
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
				print( display.viewableContentHeight )
				print( display.viewableContentWidth )
				native.showWebPopup( xa, ya, ww, wh, 
				                  "ad.html", 
				                  {urlRequest=listener, hasBackground=false, baseUrl=system.DocumentsDirectory} )
        end
end

function showPromotion(queryAdListener )
	queryListener = queryAdListener
	
	native.setActivityIndicator( true )
	o = "landscape"
	if nil ~= string.find(system.orientation, "landscape") then
		o = "landscape"
	end
	if nil ~= string.find(system.orientation, "portrait") then
		o = "portrait"
	end
	network.request( "http://dev.appsperse.com/api?device_type="..model.."&device_mac="..deviceID.."&app_key="..app_key.."&promotion_type=interstitial&v=1.0b3&device_app_uuid="..deviceID.."&screen_orientation="..o.."&country=US&language=en&method=htmlpromotion&device_bundle_id=com.appsperse.Corona&demo_mode="..demo.."&device_id="..deviceID.."&", "GET", networkListener )
end

function trackPurchase(transaction, productIdentifier)
	lastTransaction = transaction
	store.loadProducts( {productIdentifier}, productCallback )	
end