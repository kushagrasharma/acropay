import json
from django.http import HttpResponse
from django.http import JsonResponse

# Using Django (https://www.djangoproject.com/)
def my_customer_view(request):
  try:
    customer_id = "..." # Load the Stripe Customer ID for your logged in user
    customer = stripe.Customer.retrieve(customer_id)
    return JsonResponse(customer)
  except stripe.error.StripeError as e:
    return HttpResponse(status=402)