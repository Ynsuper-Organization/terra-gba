# Hướng dẫn cấu hình DNS cho gba.terracam.space

## Vấn đề hiện tại
GitHub Pages báo lỗi: "Domain's DNS record could not be retrieved (InvalidDNSError)"

## Giải pháp: Sử dụng A Records thay vì CNAME

### Bước 1: Xóa CNAME record hiện tại
Trong DNS provider của bạn (nơi quản lý terracam.space), **XÓA** CNAME record:
- Type: CNAME
- Name: gba
- Value: ynsuper-organization.github.io.

### Bước 2: Thêm 4 A Records
Thêm **4 bản ghi A** cho `gba.terracam.space` với các IP sau:

```
Type: A
Name: gba
Value: 185.199.108.153
TTL: 3600 (hoặc auto)

Type: A
Name: gba
Value: 185.199.109.153
TTL: 3600 (hoặc auto)

Type: A
Name: gba
Value: 185.199.110.153
TTL: 3600 (hoặc auto)

Type: A
Name: gba
Value: 185.199.111.153
TTL: 3600 (hoặc auto)
```

### Bước 3: Đợi DNS propagate
- Đợi 10-30 phút để DNS propagate
- Kiểm tra bằng lệnh: `dig gba.terracam.space +short`

### Bước 4: Xác minh lại trên GitHub
1. Vào: https://github.com/Ynsuper-Organization/terra-gba/settings/pages
2. Trong phần "Custom domain":
   - Xóa domain hiện tại (nếu có)
   - Thêm lại: `gba.terracam.space`
   - Click "Save"
3. Đợi GitHub xác minh (có thể mất vài phút)

### Bước 5: Kiểm tra
Sau khi xác minh thành công, website sẽ có sẵn tại:
- https://gba.terracam.space

## Lưu ý quan trọng
- **KHÔNG** dùng cả CNAME và A records cùng lúc
- Chỉ dùng **A records** cho subdomain
- Đảm bảo file CNAME trong repository vẫn chứa: `gba.terracam.space`

