schema = {
    'price': {
        'type': 'integer',
        'required': True
    },
    'name': {
        'type': 'string',
        'required': True
    }
}

people = {
    'schema': schema
}
MONGO_DBNAME = 'products'
DOMAIN = {
    'products': people,
}