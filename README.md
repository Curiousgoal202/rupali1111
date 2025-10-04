# 💳 SecurePay — Payment Gateway App (DevOps CI/CD)

## Tools Used
- AWS EC2 (Linux)
- Jenkins
- Git + GitHub
- Flask (Python web app)

## CI/CD Flow
1. **Developer pushes code** → GitHub
2. **Webhook triggers Jenkins**
3. Jenkins runs:
   - Build & Test
   - Package (tar.gz)
   - SCP artifact to EC2
   - Execute deploy script
   - Health check

## Run Locally
```bash
pip install -r app/requirements.txt
python app/app.py
