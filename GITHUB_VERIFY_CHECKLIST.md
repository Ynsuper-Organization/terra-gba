# 🔍 Kiểm tra và khắc phục theo tài liệu GitHub

Theo [tài liệu GitHub về custom domain](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site):

## ✅ Kiểm tra hiện tại:

### 1. DNS Records - ✅ ĐÃ ĐÚNG
- ✅ 4 A records: 185.199.108.153, 185.199.109.153, 185.199.110.153, 185.199.111.153
- ✅ Không có CNAME record
- ✅ Website đang hoạt động: http://gba.terracam.space và https://gba.terracam.space

### 2. File CNAME trong repository - ✅ ĐÃ ĐÚNG
- ✅ File CNAME có nội dung: `gba.terracam.space`

## 🔧 Các bước khắc phục theo tài liệu GitHub:

### Bước 1: Kiểm tra file CNAME trong repository

Theo tài liệu, file CNAME phải:
- ✅ Tên file: `CNAME` (viết hoa toàn bộ)
- ✅ Nội dung: Chỉ có domain name (không có http:// hoặc https://)
- ✅ Vị trí: Thư mục gốc của branch được publish

**Kiểm tra:**
```bash
cat CNAME
# Phải thấy: gba.terracam.space
```

### Bước 2: Verify domain trên GitHub

Theo [tài liệu GitHub](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site):

1. **Vào Settings → Pages:**
   - URL: https://github.com/Ynsuper-Organization/terra-gba/settings/pages

2. **Trong phần "Custom domain":**
   - Nếu domain chưa được thêm: Thêm `gba.terracam.space`
   - Nếu domain đã có nhưng báo lỗi:
     - Click **"Remove"** bên cạnh domain
     - **Đợi 5 phút**
     - Gõ lại: `gba.terracam.space`
     - Click **"Save"**

3. **GitHub sẽ tự động:**
   - Tạo/update file CNAME trong repository
   - Verify DNS records
   - Cấp SSL certificate (có thể mất vài giờ)

### Bước 3: Kiểm tra DNS từ nhiều locations

GitHub có thể query DNS từ nhiều locations khác nhau. Đảm bảo tất cả đều trả về đúng:

```bash
# Google DNS
dig @8.8.8.8 gba.terracam.space A +short

# Cloudflare DNS
dig @1.1.1.1 gba.terracam.space A +short

# OpenDNS
dig @208.67.222.222 gba.terracam.space A +short
```

Tất cả phải trả về **4 IP addresses**.

### Bước 4: Đợi DNS propagate

Theo tài liệu GitHub:
- DNS changes có thể mất **đến 24 giờ** để propagate hoàn toàn
- Đợi ít nhất **30 phút** sau khi thay đổi DNS

### Bước 5: Kiểm tra lại trên GitHub

Sau khi đợi:
1. Vào lại Settings → Pages
2. Kiểm tra trạng thái domain:
   - ⏳ "Checking DNS..." = Đang verify
   - ✅ Green checkmark = Verify thành công
   - ❌ Red X = Verify thất bại

## ⚠️ Các vấn đề thường gặp:

### 1. File CNAME không đúng format
- ❌ `http://gba.terracam.space`
- ❌ `https://gba.terracam.space`
- ✅ `gba.terracam.space`

### 2. DNS chưa propagate
- Đợi ít nhất 30 phút sau khi thay đổi DNS
- Kiểm tra từ nhiều DNS servers

### 3. Có CNAME record conflict
- Đảm bảo không có CNAME record cho domain gốc
- Chỉ dùng A records cho subdomain (hoặc CNAME, không dùng cả hai)

### 4. GitHub chưa verify
- Thử xóa và thêm lại domain trong GitHub Settings
- Đợi GitHub verify lại (có thể mất vài giờ)

## 📋 Checklist đầy đủ:

- [ ] File CNAME trong repository có nội dung đúng: `gba.terracam.space`
- [ ] 4 A records đã được cấu hình trong DNS provider
- [ ] Không có CNAME record (hoặc đã xóa)
- [ ] Đã đợi ít nhất 30 phút sau khi thay đổi DNS
- [ ] Đã thêm domain trong GitHub Settings → Pages
- [ ] Đã thử xóa và thêm lại domain (nếu vẫn lỗi)
- [ ] Đã đợi GitHub verify (có thể mất vài giờ)

## 🔍 Debug commands:

```bash
# Kiểm tra DNS
./verify_dns.sh

# Kiểm tra file CNAME
cat CNAME

# Kiểm tra website
curl -I http://gba.terracam.space
curl -I https://gba.terracam.space

# Kiểm tra DNS từ nhiều locations
dig @8.8.8.8 gba.terracam.space A +short
dig @1.1.1.1 gba.terracam.space A +short
```

## 📚 Tham khảo:

- [GitHub Docs: Configuring a custom domain](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site)
- [GitHub Docs: Troubleshooting custom domains](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/troubleshooting-a-custom-domain)

