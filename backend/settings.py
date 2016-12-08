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

people = {
    'schema': schema
}
DOMAIN = {
    'products': people,
}