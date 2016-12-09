
#1
import sys
import json
import cgi
import cgitb
import stripe
 
#2
cgitb.enable()
 
print 'Content-Type: text/json'     
print                               
 
#3
stripe.api_key = ' sk_test_9yYMAQqoxKVttd23W7Ftz317'
 
#4
json_data = sys.stdin.read()
json_dict = json.loads(json_data)
 
#5
stripeAmount = json_dict['amount']
stripeCurrency = json_dict['usd']
stripeToken = json_dict['stripeToken']

#6
json_response = stripe.Charge.create(amount=stripeAmount, currency=stripeCurrency, card=stripeToken)
 
print json_response