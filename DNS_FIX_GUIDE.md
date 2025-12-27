# 🔧 Hướng dẫn sửa lỗi DNS cho gba.terracam.space

## ❌ Vấn đề hiện tại
GitHub Pages báo lỗi: "Domain's DNS record could not be retrieved (InvalidDNSError)"
Mặc dù DNS đã được cấu hình và đang hoạt động.

## ✅ Giải pháp: Chuyển từ CNAME sang A Records

GitHub Pages có thể yêu cầu **A records** thay vì CNAME cho subdomain để xác minh đúng cách.

### Bước 1: Xóa CNAME record hiện tại

Trong DNS provider của bạn (nơi quản lý terracam.space), **XÓA** record sau:
```
Type: CNAME
Name: gba
Value: ynsuper-organization.github.io.
```

### Bước 2: Thêm 4 A Records

Thêm **4 bản ghi A** (KHÔNG phải CNAME) với các giá trị sau:

```
Record 1:
Type: A
Name: gba
Value: 185.199.108.153
TTL: 3600 (hoặc auto)

Record 2:
Type: A
Name: gba
Value: 185.199.109.153
TTL: 3600 (hoặc auto)

Record 3:
Type: A
Name: gba
Value: 185.199.110.153
TTL: 3600 (hoặc auto)

Record 4:
Type: A
Name: gba
Value: 185.199.111.153
TTL: 3600 (hoặc auto)
```

**QUAN TRỌNG:**
- Phải thêm **CẢ 4** A records
- **KHÔNG** dùng CNAME
- Name chỉ cần là `gba` (không cần `gba.terracam.space`)

### Bước 3: Đợi DNS propagate

- Đợi **ít nhất 10-30 phút** sau khi thêm A records
- Kiểm tra bằng lệnh: `dig gba.terracam.space A +short`
- Phải thấy **4 IP addresses** được liệt kê

### Bước 4: Xóa và thêm lại domain trên GitHub

1. Vào: https://github.com/Ynsuper-Organization/terra-gba/settings/pages
2. Trong phần "Custom domain":
   - **XÓA** domain `gba.terracam.space` (nếu có)
   - Đợi 1-2 phút
   - **THÊM LẠI** domain: `gba.terracam.space`
   - Click "Save"
3. Đợi GitHub xác minh (có thể mất 5-10 phút)

### Bước 5: Kiểm tra lại

Sau khi hoàn tất, chạy:
```bash
./check_dns.sh
```

Phải thấy 4 A records được liệt kê.

## 🔍 Tại sao phải dùng A records?

- GitHub Pages có thể yêu cầu A records cho subdomain để xác minh chính xác
- Một số DNS provider không hỗ trợ CNAME cho subdomain đúng cách
- A records cho phép GitHub kiểm tra DNS dễ dàng hơn

## ⚠️ Lưu ý

- File `CNAME` trong repository vẫn phải có: `gba.terracam.space`
- **KHÔNG** dùng cả CNAME và A records cùng lúc
- Đảm bảo đã xóa CNAME trước khi thêm A records

