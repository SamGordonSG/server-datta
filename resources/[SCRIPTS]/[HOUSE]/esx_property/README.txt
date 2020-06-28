FEATURES:
- Standard esx_property features
- Allows you to have roommates in your properties (only 2 people per property, you and a rommate)
   If the other person has already bought the property, they can only go into their property (not yours because this would cause bugs)
   Due to limitations of instance, when the person that goes into the property first (host of instance) leaves, it kicks the other person in the property (if present)

REQUIREMENTS:
- ESX
- instance
- cron
- esx_addonaccount
- esx_addoninventory
- esx_datastore

INSTALLATION:
- If you have original esx_property, disable it and rename/remove it
- Import esx_property.sql and offices.sql into your database (if you haven't already done so with original esx_property)
- Import new.sql into your database
- Put the resource in your resources directory
- Add this in your server.cfg
   start esx_property
- If you want to translate this into other languages, check the bottom of the locales/en.lua file

CREDITS:
- Jérémie N'gadi (original creator of esx_property)
- Elipse458 (FiveM network edit of esx_property)
