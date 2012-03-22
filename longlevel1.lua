
-- longlevel1.lua 2011-03-22T23:53:42.575-07:00

-- Stub class for _longlevel1.lua. All modifications will be preserved.

module(..., package.seeall)
local physics = require("physics")
local imagelookup = require("_imagelookup")
local ui = require("ui")
local game
local native = require("native")
products = nil

local function queryAdListener( event )
	if( event.hasAd ) then
		print ("Ad filled")
	end
	if nil ~= string.find( event.eventType, "didReceiveResponse" ) then
		print ("The system received a network response from the ad network")
		--native.setActivityIndicator( false );
	end
	if nil ~= string.find( event.eventType, "responseError" ) then
		print ("There was a network problem")
		--native.setActivityIndicator( false );
	end
	if nil ~= string.find( event.eventType, "willRequestAd" ) then
		print ("About to send a network request for an ad")
		--native.setActivityIndicator( true );
	end
	if nil ~= string.find( event.eventType, "adShowing" ) then
		print ("The ad is showing")
	end
	if nil ~= string.find( event.eventType, "adStartShowing" ) then
		print ("The ad is going to show")
	end
	if nil ~= string.find( event.eventType, "adShowingError" ) then
		print ("There was an error showing the ad")
	end
	if nil ~= string.find( event.eventType, "adTap" ) then
		print ("The user tapped the ad")
	end
	if nil ~= string.find( event.eventType, "adClose" ) then
		print ("The user closed the ad")
	end
end

appsperseAd = require("Appsperse")
appsperseAd.init("69d94d4b7f114cae83b2fa1163b607d2", queryAdListener)

store = require("store")

function transactionCallback( event )
        local transaction = event.transaction
        if transaction.state == "purchased" then
                print("Transaction succuessful!")
				appsperseAd.trackPurchase(transaction, products[1])
 
        elseif  transaction.state == "restored" then
                print("Transaction restored (from previous session)")
                print("productIdentifier", transaction.productIdentifier)
                print("receipt", transaction.receipt)
                print("transactionIdentifier", transaction.identifier)
                print("date", transaction.date)
                print("originalReceipt", transaction.originalReceipt)
                print("originalTransactionIdentifier", transaction.originalIdentifier)
                print("originalDate", transaction.originalDate)
 
        elseif transaction.state == "cancelled" then
                print("User cancelled transaction")
 
        elseif transaction.state == "failed" then
                print("Transaction failed, type:", transaction.errorType, transaction.errorString)
 
        else
                print("unknown event")
        end
 
        -- Once we are done with a transaction, call this to tell the store
        -- we are done with the transaction.
        -- If you are providing downloadable content, wait to call this until
        -- after the download completes.
        store.finishTransaction( transaction )
end
 
if store.availableStores.apple then
    store.init("apple", transactionCallback)
   
elseif store.availableStores.google then
    store.init("google", transactionCallback)
end

function loadProductsCallback( event )
        print("showing products", #event.products)
		products = event.products
        for i=1, #event.products do
                local currentItem = event.products[i]
                print(currentItem.title)
                print(currentItem.description)
                print(currentItem.price)
                print(currentItem.productIdentifier)
        end
        print("showing invalidProducts", #event.invalidProducts)
        for i=1, #event.invalidProducts do
                print(event.invalidProducts[i])
        end
end
 
arrayOfProductIdentifiers = 
{
        "com.appsperse.beepower",
}

if store.availableStores.apple then
	store.loadProducts( arrayOfProductIdentifiers, loadProductsCallback )
end

local shakeListener = function( event )
	print("shake")
        if event.isShake then
			appsperseAd.show()
			if store.availableStores.apple then
				store.purchase( arrayOfProductIdentifiers )
			else
				store.purchase( { "android.test.purchased" } )
			end
		end
		
end
Runtime:addEventListener( "accelerometer", shakeListener )

function new ()
	local super = require("_longlevel1")
	local this = super:newLongLevel1()
	
	this.bee.collisionCommand = "bee"
	this.coin1.collisionCommand = "coin"
	this.coin1.points = 10
	this.coin2.collisionCommand = "coin"
	this.coin2.points = 10
	this.coin3.collisionCommand = "coin"
	this.coin3.points = 10
	
	game = require("GameMechanics")
	game.configLevel(this.bee, this, -1800)
	
	return this
end
