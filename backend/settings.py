schema = {
    'price': {
        'type': 'number',
        'required': True
    },
    'name': {
        'type': 'string',
        'required': True
    }
}

products = {
    'additional_lookup': {
        'url': 'regex("[\w]+")',
        'field': 'price'
    },
    'schema': schema
}
DOMAIN = {
    'products': products,
}