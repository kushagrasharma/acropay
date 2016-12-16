import stripe
stripe.api_key = "sk_test_9yYMAQqoxKVttd23W7Ftz317"


customer = stripe.Customer.retrieve({CUSTOMER_ID})
customer.sources.create(source={TOKEN_ID})

<Card card id=card_19OQOQJbF1hSakIvhe1K3JpQ at 0x00000a> JSON: {
  "id": "card_19OQOQJbF1hSakIvhe1K3JpQ",
  "object": "card",
  "address_city": null,
  "address_country": null,
  "address_line1": null,
  "address_line1_check": null,
  "address_line2": null,
  "address_state": null,
  "address_zip": null,
  "address_zip_check": null,
  "brand": "Visa",
  "country": "US",
  "customer": "cus_9hprkHbIle0e08",
  "cvc_check": null,
  "dynamic_last4": null,
  "exp_month": 8,
  "exp_year": 2017,
  "funding": "credit",
  "last4": "4242",
  "metadata": {
  },
  "name": null,
  "tokenization_method": null
}