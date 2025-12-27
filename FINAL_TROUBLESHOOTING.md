# 🔧 Khắc phục cuối cùng - GitHub Pages Custom Domain

## 🔍 Phát hiện:

DNS có vẻ không nhất quán giữa các DNS servers:
- Một số servers trả về đủ 4 A records
- Một số servers chỉ trả về 2 A records

GitHub có thể query DNS từ nhiều locations khác nhau, nên cần đảm bảo **TẤT CẢ** DNS servers đều trả về đủ 4 A records.

## ✅ Giải pháp theo tài liệu GitHub:

### Bước 1: Đảm bảo DNS đã được cấu hình đúng

Trong DNS provider của bạn, đảm bảo có **CHÍNH XÁC 4 A records**:

```
Type: A
Name: gba
Value: 185.199.108.153
TTL: 3600 (hoặc thấp hơn để propagate nhanh hơn)

Type: A
Name: gba
Value: 185.199.109.153
TTL: 3600

Type: A
Name: gba
Value: 185.199.110.153
TTL: 3600

Type: A
Name: gba
Value: 185.199.111.153
TTL: 3600
```

**QUAN TRỌNG:**
- TTL nên đặt thấp (300-600) để DNS propagate nhanh hơn
- Đảm bảo không có CNAME record
- Đảm bảo không có duplicate records

### Bước 2: Đợi DNS propagate hoàn toàn

Theo [tài liệu GitHub](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site):
- DNS changes có thể mất **đến 24 giờ** để propagate
- Đợi ít nhất **1 giờ** sau khi thay đổi DNS

### Bước 3: Kiểm tra DNS từ nhiều locations

Sau khi đợi, kiểm tra từ nhiều DNS servers:

```bash
# Google DNS
dig @8.8.8.8 gba.terracam.space A +short

# Cloudflare DNS
dig @1.1.1.1 gba.terracam.space A +short

# OpenDNS
dig @208.67.222.222 gba.terracam.space A +short

# Quad9
dig @9.9.9.9 gba.terracam.space A +short
```

**Tất cả phải trả về 4 IP addresses:**
- 185.199.108.153
- 185.199.109.153
- 185.199.110.153
- 185.199.111.153

### Bước 4: Reset domain trên GitHub

Theo tài liệu GitHub, nếu vẫn không được:

1. **Vào Settings → Pages:**
   - URL: https://github.com/Ynsuper-Organization/terra-gba/settings/pages

2. **Xóa domain:**
   - Click **"Remove"** bên cạnh `gba.terracam.space`
   - **Đợi 10 phút**

3. **Thêm lại domain:**
   - Gõ lại: `gba.terracam.space`
   - Click **"Save"**

4. **Đợi GitHub verify:**
   - GitHub sẽ tự động verify DNS
   - Có thể mất vài phút đến vài giờ
   - Bạn sẽ thấy green checkmark khi thành công

### Bước 5: Kiểm tra file CNAME

Đảm bảo file CNAME trong repository:
- ✅ Tên file: `CNAME` (viết hoa)
- ✅ Nội dung: Chỉ có `gba.terracam.space` (không có http:// hoặc https://)
- ✅ Vị trí: Thư mục gốc của branch `main`

**Kiểm tra:**
```bash
cat CNAME
# Phải thấy: gba.terracam.space
```

## ⚠️ Các vấn đề có thể gặp:

### 1. DNS chưa propagate đầy đủ
- **Giải pháp:** Đợi thêm thời gian (có thể đến 24 giờ)
- **Kiểm tra:** Query từ nhiều DNS servers

### 2. DNS provider có vấn đề
- **Giải pháp:** Kiểm tra lại cấu hình trong DNS provider
- **Kiểm tra:** Đảm bảo tất cả 4 A records đã được thêm đúng

### 3. GitHub cache
- **Giải pháp:** Xóa và thêm lại domain trong GitHub Settings
- **Đợi:** 10 phút sau khi xóa, rồi thêm lại

### 4. File CNAME không đúng
- **Giải pháp:** Kiểm tra và sửa file CNAME trong repository
- **Format:** Chỉ có domain name, không có protocol

## 📋 Checklist cuối cùng:

- [ ] Đã thêm đủ 4 A records trong DNS provider
- [ ] TTL đã được set thấp (300-600) để propagate nhanh
- [ ] Đã xóa tất cả CNAME records
- [ ] Đã đợi ít nhất 1 giờ sau khi thay đổi DNS
- [ ] Đã kiểm tra DNS từ nhiều servers (tất cả phải có 4 IPs)
- [ ] File CNAME trong repository đúng format
- [ ] Đã xóa domain khỏi GitHub Settings
- [ ] Đã đợi 10 phút
- [ ] Đã thêm lại domain trong GitHub Settings
- [ ] Đã đợi GitHub verify (có thể mất vài giờ)

## 🔍 Debug script:

Chạy script này để kiểm tra toàn bộ:

```bash
./verify_dns.sh
```

## 📞 Nếu vẫn không được:

Nếu sau khi thực hiện tất cả các bước trên và đợi 24 giờ vẫn không được:

1. **Kiểm tra lại DNS provider:**
   - Đảm bảo tất cả 4 A records đã được thêm
   - Kiểm tra không có duplicate records
   - Kiểm tra TTL settings

2. **Liên hệ GitHub Support:**
   - Có thể có vấn đề từ phía GitHub
   - Hoặc cần thêm thời gian để xử lý

3. **Kiểm tra DNS provider logs:**
   - Xem có lỗi gì trong DNS provider không

## 📚 Tham khảo:

- [GitHub Docs: Configuring a custom domain](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site)
- [GitHub Docs: Troubleshooting custom domains](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/troubleshooting-a-custom-domain)

