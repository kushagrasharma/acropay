import json
from django.http import HttpResponse
from django.http import JsonResponse

# Using Django (https://www.djangoproject.com/)
def my_customer_view(request):
  try:
    customer_id = "source.stripeID" # Load the Stripe Customer ID for your logged in user
    customer = stripe.Customer.retrieve(customer_id)
    return JsonResponse(customer)
  except stripe.error.StripeError as e:
    return HttpResponse(status=402)

# Using Django (https://www.djangoproject.com/)
def my_customer_source_view(request):
  try:
    customer_id = "source.stripeID" # Load the Stripe Customer ID for your logged in user
    customer = stripe.Customer.retrieve(customer_id)
    source = request.POST['source']
    customer.sources.create(source=source)
    return HttpResponse(status=200)
  except stripe.error.StripeError as e:
    return HttpResponse(status=402)

#Using Django (https://www.djangoproject.com/)
def my_customer_default_source_view(request):
  try:
    customer_id = "source.stripeID" # Load the Stripe Customer ID for your logged in user
    customer = stripe.Customer.retrieve(customer_id)
    customer.default_source = request.POST['default_source']
    customer.save()
    return HttpResponse(status=200)
  except stripe.error.StripeError as e:
    return HttpResponse(status=402)