import stripe
from flask import Flask
from flask import request
from flask import json

app = Flask(__name__)

@app.route('/pay', methods=['POST'])
def pay():

  # Set this to your Stripe secret key (use your test key!)
  stripe.api_key = "sk_test_51KvKHLI1WLTTyI34HGEHSfQic6IvxzFOuf8lfU3MBhG1ecPwq832k531WzuVMUu5a66BAWwwSq0pK6hsJpnbSs8I00JddfPP96"

  # Parse the request as JSON
  json = request.get_json(force=True)

  # Get the credit card details
  #token = json['stripeToken']
  amount = json['amount']
  #description = json['description']
  paymentMethod = json['payment_method']

  # Create the charge on Stripe's servers - this will charge the user's card
  try:
    #charge = stripe.Charge.create(
		#		  amount=amount,
		#		  currency="eur",
		#		  card=token,
		#		  description=description
		#	          )
    intent = stripe.PaymentIntent.create(
      amount=amount,
      currency="eur",
      payment_method=paymentMethod,
      confirm="true"
      )
    
    # stripe.PaymentIntent.confirm(
    #   intent.id,
    #   payment_method=paymentMethod,
    # )

    return "Success!"
  except stripe.CardError:
    # The card has been declined

    pass
    return "Success!"
    

if __name__ == '__main__':
  # Set as 0.0.0.0 to be accessible outside your local machine
  app.run(debug=True, host= '0.0.0.0')
