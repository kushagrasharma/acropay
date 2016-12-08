products = {
    'additional_lookup': {
        'url': 'regex("[\w]+")',
        'field': 'price'
    }
}

DOMAIN = {'products': {products}}

MONGO_DBNAME = 'products'