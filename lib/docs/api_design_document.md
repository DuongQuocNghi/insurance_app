# API Design Document - Hệ thống Bảo hiểm

## 1. Tổng quan API Architecture

### 1.1. RESTful API Principles
- **Base URL**: `https://api.insurance-app.com/v1`
- **Protocol**: HTTPS only
- **Format**: JSON
- **Authentication**: JWT Bearer Token
- **Versioning**: URL path versioning (`/v1`, `/v2`)

### 1.2. HTTP Status Codes
```
200 OK - Successful GET, PUT, PATCH
201 Created - Successful POST
204 No Content - Successful DELETE
400 Bad Request - Invalid request syntax
401 Unauthorized - Authentication required
403 Forbidden - Permission denied
404 Not Found - Resource not found
422 Unprocessable Entity - Validation errors
429 Too Many Requests - Rate limit exceeded
500 Internal Server Error - Server error
```

### 1.3. Standard Response Format
```json
{
  "success": true,
  "data": {},
  "message": "Success message",
  "errors": [],
  "meta": {
    "timestamp": "2025-06-19T10:30:00Z",
    "version": "1.0",
    "request_id": "uuid"
  }
}
```

## 2. Authentication & Authorization APIs

### 2.1. User Authentication

#### POST /auth/login
**Mô tả**: Đăng nhập người dùng
```json
// Request
{
  "email": "user@example.com",
  "password": "password123",
  "remember_me": true
}

// Response
{
  "success": true,
  "data": {
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "token_type": "Bearer",
    "expires_in": 3600,
    "user": {
      "id": 1,
      "email": "user@example.com",
      "name": "Nguyen Van A",
      "role": "customer",
      "avatar": "https://cdn.example.com/avatar.jpg"
    }
  }
}
```

#### POST /auth/register
**Mô tả**: Đăng ký tài khoản mới
```json
// Request
{
  "email": "newuser@example.com",
  "password": "password123",
  "confirm_password": "password123",
  "name": "Nguyen Van B",
  "phone": "0987654321",
  "role": "customer"
}

// Response
{
  "success": true,
  "data": {
    "user_id": 2,
    "verification_required": true,
    "message": "Please check your email for verification"
  }
}
```

#### POST /auth/refresh
**Mô tả**: Làm mới access token
```json
// Request
{
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}

// Response
{
  "success": true,
  "data": {
    "access_token": "new_access_token",
    "expires_in": 3600
  }
}
```

#### POST /auth/logout
**Mô tả**: Đăng xuất và vô hiệu hóa token
```json
// Request
Headers: Authorization: Bearer {access_token}

// Response
{
  "success": true,
  "message": "Logged out successfully"
}
```

### 2.2. Password Management

#### POST /auth/forgot-password
```json
// Request
{
  "email": "user@example.com"
}

// Response
{
  "success": true,
  "message": "Password reset link sent to your email"
}
```

#### POST /auth/reset-password
```json
// Request
{
  "token": "reset_token_from_email",
  "password": "new_password123",
  "confirm_password": "new_password123"
}

// Response
{
  "success": true,
  "message": "Password reset successfully"
}
```

## 3. User Management APIs

### 3.1. User Profile

#### GET /users/profile
**Mô tả**: Lấy thông tin profile người dùng hiện tại
```json
// Response
{
  "success": true,
  "data": {
    "id": 1,
    "email": "user@example.com",
    "name": "Nguyen Van A",
    "phone": "0987654321",
    "date_of_birth": "1990-01-01",
    "address": {
      "street": "123 Nguyen Trai",
      "district": "District 1",
      "city": "Ho Chi Minh City",
      "postal_code": "70000"
    },
    "identity_card": {
      "number": "123456789",
      "issued_date": "2015-01-01",
      "issued_place": "Ho Chi Minh City"
    },
    "avatar": "https://cdn.example.com/avatar.jpg",
    "kyc_status": "verified",
    "created_at": "2025-01-01T00:00:00Z",
    "updated_at": "2025-06-19T10:30:00Z"
  }
}
```

#### PUT /users/profile
**Mô tả**: Cập nhật thông tin profile
```json
// Request
{
  "name": "Nguyen Van A Updated",
  "phone": "0987654322",
  "address": {
    "street": "456 Le Loi",
    "district": "District 3",
    "city": "Ho Chi Minh City",
    "postal_code": "70000"
  }
}

// Response
{
  "success": true,
  "data": {
    "id": 1,
    "name": "Nguyen Van A Updated",
    // ... updated profile data
  }
}
```

### 3.2. KYC (Know Your Customer)

#### POST /users/kyc/upload-documents
**Mô tả**: Upload giấy tờ KYC
```json
// Request (multipart/form-data)
{
  "identity_front": "file_upload",
  "identity_back": "file_upload",
  "selfie": "file_upload",
  "document_type": "identity_card"
}

// Response
{
  "success": true,
  "data": {
    "kyc_request_id": "kyc_123456",
    "status": "pending_review",
    "documents": [
      {
        "type": "identity_front",
        "url": "https://secure.example.com/documents/id_front.jpg",
        "uploaded_at": "2025-06-19T10:30:00Z"
      }
    ]
  }
}
```

#### GET /users/kyc/status
**Mô tả**: Kiểm tra trạng thái KYC
```json
// Response
{
  "success": true,
  "data": {
    "status": "verified", // pending, in_review, verified, rejected
    "verified_at": "2025-06-19T10:30:00Z",
    "documents_status": {
      "identity_card": "verified",
      "selfie": "verified"
    },
    "rejection_reason": null
  }
}
```

## 4. Product Management APIs

### 4.1. Insurance Products

#### GET /products
**Mô tả**: Lấy danh sách sản phẩm bảo hiểm
```json
// Query Parameters
?category=vehicle&type=mandatory&page=1&limit=10&search=TNDS

// Response
{
  "success": true,
  "data": {
    "products": [
      {
        "id": 1,
        "name": "Bảo hiểm TNDS xe máy",
        "category": "vehicle",
        "type": "mandatory",
        "description": "Bảo hiểm trách nhiệm dân sự bắt buộc xe máy",
        "coverage_amount": 150000000,
        "base_premium": 66000,
        "features": [
          "Bồi thường thiệt hại về người",
          "Bồi thường thiệt hại về tài sản",
          "Chi phí cứu chữa khẩn cấp"
        ],
        "documents_required": [
          "Đăng ký xe",
          "CMND/CCCD chủ xe",
          "Giấy phép lái xe"
        ],
        "terms_url": "https://example.com/terms/tnds-xe-may.pdf",
        "is_active": true,
        "created_at": "2025-01-01T00:00:00Z"
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 5,
      "total_items": 50,
      "per_page": 10
    }
  }
}
```

#### GET /products/{id}
**Mô tả**: Lấy chi tiết sản phẩm
```json
// Response
{
  "success": true,
  "data": {
    "id": 1,
    "name": "Bảo hiểm TNDS xe máy",
    "category": "vehicle",
    "type": "mandatory",
    "description": "Bảo hiểm trách nhiệm dân sự bắt buộc xe máy",
    "detailed_description": "Sản phẩm bảo hiểm TNDS xe máy...",
    "coverage_details": {
      "person_damage": {
        "max_amount": 150000000,
        "description": "Bồi thường thiệt hại về người"
      },
      "property_damage": {
        "max_amount": 50000000,
        "description": "Bồi thường thiệt hại về tài sản"
      }
    },
    "premium_calculation": {
      "base_amount": 66000,
      "factors": [
        {
          "name": "engine_capacity",
          "multiplier": 1.0,
          "description": "Dung tích xi-lanh"
        }
      ]
    },
    "terms_and_conditions": "https://example.com/terms/tnds-xe-may.pdf",
    "sample_contract": "https://example.com/samples/tnds-xe-may-sample.pdf"
  }
}
```

### 4.2. Premium Calculation

#### POST /products/{id}/calculate-premium
**Mô tả**: Tính phí bảo hiểm
```json
// Request
{
  "vehicle_info": {
    "type": "motorcycle",
    "engine_capacity": 150,
    "year": 2023,
    "value": 50000000
  },
  "coverage_options": {
    "voluntary_coverage": true,
    "extended_coverage": false
  },
  "duration_months": 12
}

// Response
{
  "success": true,
  "data": {
    "base_premium": 66000,
    "additional_fees": {
      "voluntary_coverage": 100000,
      "service_fee": 5000
    },
    "discounts": {
      "loyalty_discount": -10000,
      "online_discount": -5000
    },
    "total_premium": 156000,
    "breakdown": [
      {
        "item": "Phí bảo hiểm bắt buộc",
        "amount": 66000
      },
      {
        "item": "Bảo hiểm tự nguyện",
        "amount": 100000
      },
      {
        "item": "Phí dịch vụ",
        "amount": 5000
      },
      {
        "item": "Giảm giá khách hàng thân thiết",
        "amount": -10000
      },
      {
        "item": "Giảm giá mua online",
        "amount": -5000
      }
    ],
    "valid_until": "2025-06-20T10:30:00Z",
    "quote_id": "quote_123456"
  }
}
```

## 5. Policy Management APIs

### 5.1. Policy Purchase

#### POST /policies/purchase
**Mô tả**: Mua bảo hiểm
```json
// Request
{
  "quote_id": "quote_123456",
  "product_id": 1,
  "insured_info": {
    "name": "Nguyen Van A",
    "identity_number": "123456789",
    "phone": "0987654321",
    "email": "user@example.com",
    "address": "123 Nguyen Trai, District 1, HCMC"
  },
  "vehicle_info": {
    "license_plate": "59A1-12345",
    "engine_number": "ENG123456",
    "chassis_number": "CHA123456",
    "registration_date": "2023-01-15"
  },
  "payment_method": "vnpay",
  "coverage_start_date": "2025-06-20"
}

// Response
{
  "success": true,
  "data": {
    "policy_id": "POL_2025_000001",
    "status": "pending_payment",
    "premium_amount": 156000,
    "payment_url": "https://vnpay.vn/payment/...",
    "payment_deadline": "2025-06-21T10:30:00Z",
    "policy_details": {
      "effective_date": "2025-06-20T00:00:00Z",
      "expiry_date": "2026-06-19T23:59:59Z",
      "coverage_amount": 150000000
    }
  }
}
```

#### GET /policies
**Mô tả**: Lấy danh sách hợp đồng bảo hiểm
```json
// Query Parameters
?status=active&page=1&limit=10

// Response
{
  "success": true,
  "data": {
    "policies": [
      {
        "id": "POL_2025_000001",
        "product_name": "Bảo hiểm TNDS xe máy",
        "status": "active",
        "premium_amount": 156000,
        "coverage_amount": 150000000,
        "effective_date": "2025-06-20T00:00:00Z",
        "expiry_date": "2026-06-19T23:59:59Z",
        "insured_object": "59A1-12345",
        "next_payment_date": null,
        "certificate_url": "https://example.com/certificates/POL_2025_000001.pdf"
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 3,
      "total_items": 25,
      "per_page": 10
    }
  }
}
```

#### GET /policies/{policy_id}
**Mô tả**: Lấy chi tiết hợp đồng
```json
// Response
{
  "success": true,
  "data": {
    "id": "POL_2025_000001",
    "product": {
      "id": 1,
      "name": "Bảo hiểm TNDS xe máy",
      "category": "vehicle"
    },
    "status": "active",
    "premium_amount": 156000,
    "coverage_amount": 150000000,
    "effective_date": "2025-06-20T00:00:00Z",
    "expiry_date": "2026-06-19T23:59:59Z",
    "insured_info": {
      "name": "Nguyen Van A",
      "identity_number": "123456789",
      "phone": "0987654321",
      "email": "user@example.com"
    },
    "vehicle_info": {
      "license_plate": "59A1-12345",
      "engine_number": "ENG123456",
      "chassis_number": "CHA123456"
    },
    "beneficiaries": [
      {
        "name": "Nguyen Thi B",
        "relationship": "spouse",
        "percentage": 100
      }
    ],
    "payment_history": [
      {
        "date": "2025-06-19T10:30:00Z",
        "amount": 156000,
        "method": "vnpay",
        "status": "completed",
        "receipt_url": "https://example.com/receipts/receipt_001.pdf"
      }
    ],
    "certificate_url": "https://example.com/certificates/POL_2025_000001.pdf",
    "contract_url": "https://example.com/contracts/POL_2025_000001.pdf"
  }
}
```

### 5.2. Policy Renewal

#### POST /policies/{policy_id}/renew
**Mô tả**: Gia hạn hợp đồng
```json
// Request
{
  "duration_months": 12,
  "update_info": {
    "vehicle_value": 45000000
  }
}

// Response
{
  "success": true,
  "data": {
    "renewal_quote_id": "renewal_quote_123",
    "new_premium": 148000,
    "effective_date": "2026-06-20T00:00:00Z",
    "expiry_date": "2027-06-19T23:59:59Z",
    "payment_deadline": "2026-06-15T23:59:59Z"
  }
}
```

## 6. Claims Management APIs

### 6.1. Claim Submission

#### POST /claims
**Mô tả**: Tạo yêu cầu bồi thường
```json
// Request (multipart/form-data)
{
  "policy_id": "POL_2025_000001",
  "incident_date": "2025-06-18T14:30:00Z",
  "incident_location": "Nguyen Trai Street, District 1, HCMC",
  "incident_description": "Tai nạn giao thông với xe khác",
  "damage_description": "Hư hỏng đầu xe, kính chắn gió vỡ",
  "estimated_damage_amount": 5000000,
  "police_report_number": "CSGT_2025_001234",
  "photos": [
    "file_upload", // Damage photos
    "file_upload"
  ],
  "documents": [
    "file_upload" // Police report, medical records, etc.
  ],
  "witness_info": {
    "name": "Nguyen Van C",
    "phone": "0987654323"
  }
}

// Response
{
  "success": true,
  "data": {
    "claim_id": "CLM_2025_000001",
    "status": "submitted",
    "incident_date": "2025-06-18T14:30:00Z",
    "submitted_at": "2025-06-19T10:30:00Z",
    "estimated_processing_time": "7-10 business days",
    "next_steps": [
      "Our adjuster will contact you within 24 hours",
      "Please keep all original receipts",
      "Do not repair the vehicle until assessment is complete"
    ],
    "contact_person": {
      "name": "Le Thi D",
      "phone": "0987654324",
      "email": "adjuster@insurance.com"
    }
  }
}
```

#### GET /claims
**Mô tả**: Lấy danh sách yêu cầu bồi thường
```json
// Query Parameters
?status=in_progress&page=1&limit=10

// Response
{
  "success": true,
  "data": {
    "claims": [
      {
        "id": "CLM_2025_000001",
        "policy_id": "POL_2025_000001",
        "status": "in_progress",
        "incident_date": "2025-06-18T14:30:00Z",
        "submitted_at": "2025-06-19T10:30:00Z",
        "estimated_amount": 5000000,
        "approved_amount": null,
        "next_action": "Waiting for adjuster assessment"
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 2,
      "total_items": 15,
      "per_page": 10
    }
  }
}
```

#### GET /claims/{claim_id}
**Mô tả**: Lấy chi tiết yêu cầu bồi thường
```json
// Response
{
  "success": true,
  "data": {
    "id": "CLM_2025_000001",
    "policy": {
      "id": "POL_2025_000001",
      "product_name": "Bảo hiểm TNDS xe máy"
    },
    "status": "approved",
    "incident_date": "2025-06-18T14:30:00Z",
    "incident_location": "Nguyen Trai Street, District 1, HCMC",
    "incident_description": "Tai nạn giao thông với xe khác",
    "damage_description": "Hư hỏng đầu xe, kính chắn gió vỡ",
    "estimated_amount": 5000000,
    "approved_amount": 4500000,
    "deductible": 500000,
    "settlement_amount": 4000000,
    "timeline": [
      {
        "date": "2025-06-19T10:30:00Z",
        "status": "submitted",
        "description": "Claim submitted by customer",
        "actor": "customer"
      },
      {
        "date": "2025-06-19T14:00:00Z",
        "status": "assigned",
        "description": "Claim assigned to adjuster Le Thi D",
        "actor": "system"
      },
      {
        "date": "2025-06-20T09:00:00Z",
        "status": "assessed",
        "description": "Damage assessment completed",
        "actor": "adjuster"
      },
      {
        "date": "2025-06-21T11:00:00Z",
        "status": "approved",
        "description": "Claim approved for settlement",
        "actor": "manager"
      }
    ],
    "documents": [
      {
        "type": "police_report",
        "name": "Police Report.pdf",
        "url": "https://secure.example.com/documents/police_report.pdf",
        "uploaded_at": "2025-06-19T10:30:00Z"
      }
    ],
    "photos": [
      {
        "type": "damage",
        "description": "Front damage",
        "url": "https://secure.example.com/photos/damage_front.jpg",
        "uploaded_at": "2025-06-19T10:30:00Z"
      }
    ],
    "adjuster": {
      "name": "Le Thi D",
      "phone": "0987654324",
      "email": "adjuster@insurance.com"
    },
    "payment_info": {
      "method": "bank_transfer",
      "account_number": "1234567890",
      "bank_name": "Vietcombank",
      "expected_date": "2025-06-25T00:00:00Z"
    }
  }
}
```

### 6.2. Claim Updates

#### POST /claims/{claim_id}/documents
**Mô tả**: Upload thêm tài liệu cho claim
```json
// Request (multipart/form-data)
{
  "documents": ["file_upload"],
  "description": "Additional medical records"
}

// Response
{
  "success": true,
  "data": {
    "uploaded_documents": [
      {
        "id": "doc_001",
        "name": "medical_record.pdf",
        "url": "https://secure.example.com/documents/medical_record.pdf",
        "uploaded_at": "2025-06-19T10:30:00Z"
      }
    ]
  }
}
```

## 7. OCR (Optical Character Recognition) APIs

### 7.1. Document OCR

#### POST /ocr/identity-card
**Mô tả**: OCR cho CMND/CCCD
```json
// Request (multipart/form-data)
{
  "front_image": "file_upload",
  "back_image": "file_upload"
}

// Response
{
  "success": true,
  "data": {
    "extracted_data": {
      "id_number": "123456789",
      "full_name": "NGUYEN VAN A",
      "date_of_birth": "01/01/1990",
      "gender": "Nam",
      "nationality": "Việt Nam",
      "place_of_origin": "Hà Nội",
      "place_of_residence": "123 Nguyen Trai, District 1, HCMC",
      "issued_date": "01/01/2015",
      "expiry_date": "01/01/2030",
      "issued_by": "Cục Cảnh sát ĐKQL cư trú và DLQG về dân cư"
    },
    "confidence_scores": {
      "id_number": 0.98,
      "full_name": 0.95,
      "date_of_birth": 0.97,
      "overall": 0.96
    },
    "validation_results": {
      "id_number_format": true,
      "date_format": true,
      "checksum_valid": true
    }
  }
}
```

#### POST /ocr/vehicle-registration
**Mô tả**: OCR cho đăng ký xe
```json
// Request (multipart/form-data)
{
  "image": "file_upload"
}

// Response
{
  "success": true,
  "data": {
    "extracted_data": {
      "license_plate": "59A1-12345",
      "owner_name": "NGUYEN VAN A",
      "vehicle_type": "XE MÁY",
      "brand": "HONDA",
      "model": "WAVE ALPHA",
      "engine_number": "ENG123456",
      "chassis_number": "CHA123456",
      "engine_capacity": "110",
      "registration_date": "15/01/2023",
      "expiry_date": "15/01/2028"
    },
    "confidence_scores": {
      "license_plate": 0.99,
      "engine_number": 0.94,
      "chassis_number": 0.96,
      "overall": 0.97
    }
  }
}
```

## 8. Payment APIs

### 8.1. Payment Processing

#### POST /payments/create
**Mô tả**: Tạo link thanh toán
```json
// Request
{
  "policy_id": "POL_2025_000001",
  "amount": 156000,
  "payment_method": "vnpay",
  "return_url": "https://app.insurance.com/payment/success",
  "cancel_url": "https://app.insurance.com/payment/cancel"
}

// Response
{
  "success": true,
  "data": {
    "payment_id": "PAY_2025_000001",
    "payment_url": "https://vnpay.vn/payment/...",
    "qr_code": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAA...",
    "expires_at": "2025-06-19T11:30:00Z"
  }
}
```

#### GET /payments/{payment_id}/status
**Mô tả**: Kiểm tra trạng thái thanh toán
```json
// Response
{
  "success": true,
  "data": {
    "payment_id": "PAY_2025_000001",
    "status": "completed",
    "amount": 156000,
    "payment_method": "vnpay",
    "transaction_id": "VNP_TXN_123456",
    "paid_at": "2025-06-19T10:45:00Z",
    "receipt_url": "https://example.com/receipts/PAY_2025_000001.pdf"
  }
}
```

### 8.2. Payment History

#### GET /payments
**Mô tả**: Lấy lịch sử thanh toán
```json
// Query Parameters
?policy_id=POL_2025_000001&page=1&limit=10

// Response
{
  "success": true,
  "data": {
    "payments": [
      {
        "id": "PAY_2025_000001",
        "policy_id": "POL_2025_000001",
        "amount": 156000,
        "status": "completed",
        "payment_method": "vnpay",
        "paid_at": "2025-06-19T10:45:00Z",
        "receipt_url": "https://example.com/receipts/PAY_2025_000001.pdf"
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 2,
      "total_items": 12,
      "per_page": 10
    }
  }
}
```

## 9. Agent Management APIs

### 9.1. Agent Profile

#### GET /agents/profile
**Mô tả**: Lấy thông tin profile đại lý
```json
// Response
{
  "success": true,
  "data": {
    "id": 1,
    "agent_code": "AGT001",
    "name": "Tran Van B",
    "email": "agent@example.com",
    "phone": "0987654325",
    "license_number": "LIC123456",
    "license_expiry": "2025-12-31",
    "status": "active",
    "hierarchy_level": "senior",
    "manager_id": null,
    "territory": {
      "regions": ["Ho Chi Minh City", "Binh Duong"],
      "products": ["vehicle", "health", "travel"]
    },
    "performance": {
      "rank": "Gold",
      "ytd_sales": 2500000000,
      "ytd_policies": 150,
      "conversion_rate": 0.68,
      "customer_satisfaction": 4.8
    },
    "commission_rate": {
      "vehicle": 0.15,
      "health": 0.12,
      "travel": 0.10
    },
    "created_at": "2024-01-15T00:00:00Z"
  }
}
```

### 9.2. Agent Commission

#### GET /agents/commission
**Mô tả**: Lấy thông tin hoa hồng đại lý
```json
// Query Parameters
?period=2025-06&type=monthly

// Response
{
  "success": true,
  "data": {
    "period": "2025-06",
    "total_commission": 45000000,
    "paid_commission": 40000000,
    "pending_commission": 5000000,
    "breakdown": [
      {
        "product_category": "vehicle",
        "policies_sold": 25,
        "premium_volume": 150000000,
        "commission_rate": 0.15,
        "commission_amount": 22500000,
        "status": "paid"
      },
      {
        "product_category": "health",
        "policies_sold": 15,
        "premium_volume": 180000000,
        "commission_rate": 0.12,
        "commission_amount": 21600000,
        "status": "paid"
      },
      {
        "product_category": "travel",
        "policies_sold": 8,
        "premium_volume": 8000000,
        "commission_rate": 0.10,
        "commission_amount": 800000,
        "status": "pending"
      }
    ],
    "payment_schedule": [
      {
        "amount": 40000000,
        "payment_date": "2025-07-05",
        "status": "completed"
      },
      {
        "amount": 5000000,
        "payment_date": "2025-07-15",
        "status": "scheduled"
      }
    ]
  }
}
```

#### GET /agents/sales-report
**Mô tả**: Báo cáo bán hàng của đại lý
```json
// Query Parameters
?start_date=2025-06-01&end_date=2025-06-30&group_by=product

// Response
{
  "success": true,
  "data": {
    "period": {
      "start_date": "2025-06-01",
      "end_date": "2025-06-30"
    },
    "summary": {
      "total_policies": 48,
      "total_premium": 338000000,
      "total_commission": 45000000,
      "conversion_rate": 0.68
    },
    "daily_performance": [
      {
        "date": "2025-06-01",
        "policies_sold": 3,
        "premium_amount": 8500000,
        "commission": 1200000
      }
    ],
    "product_performance": [
      {
        "category": "vehicle",
        "policies_sold": 25,
        "premium_volume": 150000000,
        "commission_earned": 22500000,
        "avg_policy_value": 6000000
      }
    ],
    "top_customers": [
      {
        "customer_name": "Nguyen Van X",
        "policies_purchased": 3,
        "total_premium": 15000000,
        "last_purchase": "2025-06-25"
      }
    ]
  }
}
```

## 10. Admin APIs

### 10.1. Dashboard Analytics

#### GET /admin/dashboard
**Mô tả**: Dashboard tổng quan cho admin
```json
// Response
{
  "success": true,
  "data": {
    "overview": {
      "total_policies": 15420,
      "active_policies": 14650,
      "total_premium_ytd": 125000000000,
      "total_claims_ytd": 8500000000,
      "claim_ratio": 0.068
    },
    "monthly_stats": {
      "new_policies": 1250,
      "renewals": 890,
      "claims_submitted": 45,
      "claims_processed": 38,
      "revenue": 8500000000
    },
    "top_products": [
      {
        "product_name": "Bảo hiểm TNDS xe máy",
        "policies_count": 8500,
        "premium_volume": 55000000000,
        "growth_rate": 0.15
      }
    ],
    "recent_activities": [
      {
        "type": "policy_created",
        "description": "New policy created: POL_2025_000156",
        "timestamp": "2025-06-19T10:30:00Z",
        "user": "Nguyen Van A"
      }
    ],
    "alerts": [
      {
        "type": "high_claim_volume",
        "message": "Unusual spike in travel insurance claims",
        "severity": "warning",
        "created_at": "2025-06-19T09:00:00Z"
      }
    ]
  }
}
```

### 10.2. Policy Management

#### GET /admin/policies
**Mô tả**: Quản lý danh sách hợp đồng (Admin)
```json
// Query Parameters
?status=active&product_id=1&agent_id=5&page=1&limit=20&search=POL_2025

// Response
{
  "success": true,
  "data": {
    "policies": [
      {
        "id": "POL_2025_000001",
        "customer": {
          "name": "Nguyen Van A",
          "email": "user@example.com",
          "phone": "0987654321"
        },
        "product": {
          "name": "Bảo hiểm TNDS xe máy",
          "category": "vehicle"
        },
        "agent": {
          "name": "Tran Van B",
          "code": "AGT001"
        },
        "status": "active",
        "premium_amount": 156000,
        "coverage_amount": 150000000,
        "effective_date": "2025-06-20T00:00:00Z",
        "expiry_date": "2026-06-19T23:59:59Z",
        "created_at": "2025-06-19T10:30:00Z"
      }
    ],
    "statistics": {
      "total_policies": 15420,
      "active_policies": 14650,
      "expired_policies": 520,
      "cancelled_policies": 250
    },
    "pagination": {
      "current_page": 1,
      "total_pages": 771,
      "total_items": 15420,
      "per_page": 20
    }
  }
}
```

#### PUT /admin/policies/{policy_id}/status
**Mô tả**: Cập nhật trạng thái hợp đồng
```json
// Request
{
  "status": "cancelled",
  "reason": "Customer request",
  "effective_date": "2025-06-19T00:00:00Z",
  "refund_amount": 100000
}

// Response
{
  "success": true,
  "data": {
    "policy_id": "POL_2025_000001",
    "old_status": "active",
    "new_status": "cancelled",
    "effective_date": "2025-06-19T00:00:00Z",
    "refund_processed": true,
    "refund_amount": 100000
  }
}
```

### 10.3. Claims Management (Admin)

#### GET /admin/claims
**Mô tả**: Quản lý danh sách bồi thường (Admin)
```json
// Query Parameters
?status=pending&priority=high&adjuster_id=3&page=1&limit=20

// Response
{
  "success": true,
  "data": {
    "claims": [
      {
        "id": "CLM_2025_000001",
        "policy_id": "POL_2025_000001",
        "customer": {
          "name": "Nguyen Van A",
          "phone": "0987654321"
        },
        "product": "Bảo hiểm TNDS xe máy",
        "status": "pending_approval",
        "priority": "high",
        "incident_date": "2025-06-18T14:30:00Z",
        "submitted_at": "2025-06-19T10:30:00Z",
        "estimated_amount": 5000000,
        "adjuster": {
          "name": "Le Thi D",
          "id": 3
        },
        "days_pending": 2
      }
    ],
    "statistics": {
      "total_claims": 1250,
      "pending_claims": 45,
      "approved_claims": 1100,
      "rejected_claims": 105,
      "avg_processing_time": 5.2
    },
    "pagination": {
      "current_page": 1,
      "total_pages": 63,
      "total_items": 1250,
      "per_page": 20
    }
  }
}
```

#### PUT /admin/claims/{claim_id}/assign
**Mô tả**: Phân công adjuster cho claim
```json
// Request
{
  "adjuster_id": 5,
  "priority": "high",
  "notes": "Complex case requiring senior adjuster"
}

// Response
{
  "success": true,
  "data": {
    "claim_id": "CLM_2025_000001",
    "assigned_to": {
      "id": 5,
      "name": "Pham Van E",
      "level": "senior"
    },
    "priority": "high",
    "assigned_at": "2025-06-19T11:00:00Z"
  }
}
```

## 11. Notification APIs

### 11.1. Push Notifications

#### GET /notifications
**Mô tả**: Lấy danh sách thông báo
```json
// Query Parameters
?type=policy&status=unread&page=1&limit=20

// Response
{
  "success": true,
  "data": {
    "notifications": [
      {
        "id": "notif_001",
        "type": "policy_expiry",
        "title": "Hợp đồng bảo hiểm sắp hết hạn",
        "message": "Hợp đồng POL_2025_000001 sẽ hết hạn vào 30 ngày tới",
        "data": {
          "policy_id": "POL_2025_000001",
          "expiry_date": "2026-06-19T23:59:59Z"
        },
        "status": "unread",
        "created_at": "2025-06-19T10:30:00Z"
      },
      {
        "id": "notif_002",
        "type": "claim_update",
        "title": "Cập nhật yêu cầu bồi thường",
        "message": "Yêu cầu bồi thường CLM_2025_000001 đã được phê duyệt",
        "data": {
          "claim_id": "CLM_2025_000001",
          "status": "approved",
          "amount": 4000000
        },
        "status": "read",
        "created_at": "2025-06-18T15:30:00Z",
        "read_at": "2025-06-18T16:00:00Z"
      }
    ],
    "unread_count": 5,
    "pagination": {
      "current_page": 1,
      "total_pages": 3,
      "total_items": 48,
      "per_page": 20
    }
  }
}
```

#### PUT /notifications/{notification_id}/read
**Mô tả**: Đánh dấu thông báo đã đọc
```json
// Response
{
  "success": true,
  "data": {
    "notification_id": "notif_001",
    "status": "read",
    "read_at": "2025-06-19T11:00:00Z"
  }
}
```

### 11.2. Notification Settings

#### GET /notifications/settings
**Mô tả**: Lấy cài đặt thông báo
```json
// Response
{
  "success": true,
  "data": {
    "email_notifications": {
      "policy_expiry": true,
      "claim_updates": true,
      "payment_reminders": true,
      "promotional": false
    },
    "push_notifications": {
      "policy_expiry": true,
      "claim_updates": true,
      "payment_reminders": true,
      "promotional": false
    },
    "sms_notifications": {
      "policy_expiry": false,
      "claim_updates": true,
      "payment_reminders": true,
      "promotional": false
    }
  }
}
```

## 12. File Management APIs

### 12.1. File Upload

#### POST /files/upload
**Mô tả**: Upload file
```json
// Request (multipart/form-data)
{
  "file": "file_upload",
  "category": "claim_document", // identity, policy, claim_document, etc.
  "description": "Police report for claim CLM_2025_000001"
}

// Response
{
  "success": true,
  "data": {
    "file_id": "file_123456",
    "filename": "police_report.pdf",
    "original_name": "police_report.pdf",
    "size": 2048576,
    "mime_type": "application/pdf",
    "category": "claim_document",
    "url": "https://secure.example.com/files/file_123456.pdf",
    "secure_url": "https://secure.example.com/secure/file_123456.pdf",
    "uploaded_at": "2025-06-19T10:30:00Z",
    "expires_at": "2025-12-19T10:30:00Z"
  }
}
```

#### GET /files/{file_id}
**Mô tả**: Lấy thông tin file
```json
// Response
{
  "success": true,
  "data": {
    "file_id": "file_123456",
    "filename": "police_report.pdf",
    "original_name": "police_report.pdf",
    "size": 2048576,
    "mime_type": "application/pdf",
    "category": "claim_document",
    "description": "Police report for claim CLM_2025_000001",
    "download_url": "https://secure.example.com/files/download/file_123456",
    "uploaded_by": {
      "id": 1,
      "name": "Nguyen Van A",
      "type": "customer"
    },
    "uploaded_at": "2025-06-19T10:30:00Z",
    "download_count": 3,
    "last_accessed": "2025-06-19T11:15:00Z"
  }
}
```

## 13. Analytics & Reporting APIs

### 13.1. Business Analytics

#### GET /analytics/sales
**Mô tả**: Báo cáo doanh số bán hàng
```json
// Query Parameters
?period=monthly&start_date=2025-01-01&end_date=2025-06-30&group_by=product

// Response
{
  "success": true,
  "data": {
    "period": {
      "start_date": "2025-01-01",
      "end_date": "2025-06-30",
      "interval": "monthly"
    },
    "summary": {
      "total_premium": 75000000000,
      "total_policies": 9250,
      "avg_policy_value": 8108108,
      "growth_rate": 0.18
    },
    "monthly_data": [
      {
        "month": "2025-01",
        "premium": 10000000000,
        "policies": 1200,
        "avg_value": 8333333
      },
      {
        "month": "2025-02",
        "premium": 11500000000,
        "policies": 1350,
        "avg_value": 8518518
      }
    ],
    "product_breakdown": [
      {
        "product_category": "vehicle",
        "premium": 45000000000,
        "policies": 6500,
        "percentage": 60
      },
      {
        "product_category": "health",
        "premium": 22500000000,
        "policies": 2000,
        "percentage": 30
      },
      {
        "product_category": "travel",
        "premium": 7500000000,
        "policies": 750,
        "percentage": 10
      }
    ]
  }
}
```

#### GET /analytics/claims
**Mô tả**: Phân tích bồi thường
```json
// Query Parameters
?period=monthly&start_date=2025-01-01&end_date=2025-06-30

// Response
{
  "success": true,
  "data": {
    "summary": {
      "total_claims": 450,
      "total_claim_amount": 2250000000,
      "avg_claim_amount": 5000000,
      "claim_ratio": 0.048,
      "processing_time_avg": 5.2
    },
    "monthly_trends": [
      {
        "month": "2025-01",
        "claims_count": 65,
        "claim_amount": 325000000,
        "avg_processing_days": 4.8
      }
    ],
    "claim_types": [
      {
        "type": "vehicle_accident",
        "count": 280,
        "amount": 1400000000,
        "avg_amount": 5000000
      },
      {
        "type": "health_treatment",
        "count": 120,
        "amount": 600000000,
        "avg_amount": 5000000
      }
    ],
    "status_distribution": {
      "approved": 380,
      "rejected": 45,
      "pending": 25
    }
  }
}
```

## 14. Error Handling & Response Codes

### 14.1. Standard Error Response Format
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validation failed",
    "details": [
      {
        "field": "email",
        "message": "Email format is invalid",
        "code": "INVALID_FORMAT"
      },
      {
        "field": "phone",
        "message": "Phone number is required",
        "code": "REQUIRED_FIELD"
      }
    ]
  },
  "meta": {
    "timestamp": "2025-06-19T10:30:00Z",
    "request_id": "req_123456"
  }
}
```

### 14.2. Common Error Codes
```
AUTH_001: Invalid credentials
AUTH_002: Token expired
AUTH_003: Insufficient permissions
AUTH_004: Account locked

VALIDATION_001: Required field missing
VALIDATION_002: Invalid format
VALIDATION_003: Value out of range
VALIDATION_004: Duplicate value

BUSINESS_001: Policy not found
BUSINESS_002: Policy expired
BUSINESS_003: Claim already exists
BUSINESS_004: Insufficient coverage

SYSTEM_001: Database connection error
SYSTEM_002: External service unavailable
SYSTEM_003: File upload failed
SYSTEM_004: Rate limit exceeded
```

## 15. Rate Limiting & Security

### 15.1. Rate Limiting
```
General API: 1000 requests/hour per user
Authentication: 5 requests/minute per IP
File Upload: 10 files/minute per user
OCR Processing: 20 requests/hour per user
Payment: 5 requests/minute per user
```

### 15.2. Security Headers
```
Authorization: Bearer {jwt_token}
X-API-Key: {api_key} (for server-to-server)
X-Request-ID: {unique_request_id}
X-Client-Version: {app_version}
Content-Type: application/json
Accept: application/json
```

### 15.3. API Versioning Strategy
- URL Path Versioning: `/v1/`, `/v2/`
- Header Versioning: `Accept: application/vnd.api+json;version=1`
- Backward Compatibility: Support for N-1 versions
- Deprecation Notice: 6 months notice before removal

## 16. Testing & Documentation

### 16.1. API Testing
- **Unit Tests**: All endpoints with various scenarios
- **Integration Tests**: End-to-end workflows
- **Load Testing**: Performance under stress
- **Security Testing**: Penetration testing

### 16.2. API Documentation
- **OpenAPI 3.0 Specification**: Complete API schema
- **Interactive Documentation**: Swagger UI
- **Postman Collection**: Ready-to-use collection
- **SDK Generation**: Auto-generated client libraries

This comprehensive API design provides a solid foundation for the insurance system, covering all major functionalities with proper error handling, security measures, and scalability considerations.