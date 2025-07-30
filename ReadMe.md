viviaconnect-starter/
│
├── README.md
├── .env.example
├── package.json
├── backend/
│   ├── server.js               # Express API (Stripe Connect + Webhooks)
│   ├── routes/
│   │   ├── onboarding.js       # Connected account onboarding
│   │   ├── products.js         # Create products
│   │   └── checkout.js         # Destination charges
│   ├── webhookHandler.js       # invoice.paid, payment_failed
│   └── utils/
│       └── stripeClient.js
│
├── frontend/
│   ├── index.html              # Storefront UI
│   ├── scripts.js              # Fetch products & create sessions
│   └── styles.css
│
├── infra/
│   ├── terraform/
│   │   ├── main.tf             # S3 → Firehose → Redshift setup
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── cloudformation.yml      # Alternative to Terraform
│
├── analytics/
│   ├── looker-dashboard-template.json
│   ├── ga4-event-tracking.js
│
└── sql/
    ├── create_table.sql        # property_syndication schema
    └── copy_command.sql
