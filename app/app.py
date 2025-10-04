from flask import Flask, render_template, request, redirect, url_for, flash
import random
import string
import time

app = Flask(__name__)
app.secret_key = "securekey123"

# Simulated payment database (in-memory)
transactions = {}

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/process_payment", methods=["POST"])
def process_payment():
    card_number = request.form.get("card_number")
    amount = request.form.get("amount")

    if not card_number or not amount:
        flash("Please enter all fields!", "error")
        return redirect(url_for("index"))

    # Simulate payment processing
    time.sleep(1)
    txn_id = ''.join(random.choices(string.ascii_uppercase + string.digits, k=10))
    status = random.choice(["SUCCESS", "FAILED"])

    transactions[txn_id] = {
        "amount": amount,
        "status": status,
        "timestamp": time.strftime("%Y-%m-%d %H:%M:%S")
    }

    flash(f"Transaction {txn_id} - Status: {status}", "info")
    return redirect(url_for("transactions_list"))

@app.route("/transactions")
def transactions_list():
    return render_template("transactions.html", transactions=transactions)

@app.route("/health")
def health():
    return "OK", 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8085)
