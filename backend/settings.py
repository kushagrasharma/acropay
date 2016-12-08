VERSIONING = True
ITEM_URL = 'regex("[a-z0-9]{0,24}")'
MONGO_DBNAME = 'products'
DOMAIN = {
    'products': {
        'item_lookup_field': 'barcode',
        'type': 'dict'
    }
}

