# ⚠️ Vấn đề: DNS Cache - CNAME vẫn còn trên một số DNS servers

## 🔍 Phát hiện:
Một số DNS servers (như OpenDNS) vẫn trả về CNAME record, có thể do cache DNS.

## ✅ Giải pháp:

### Giải pháp 1: Đợi DNS cache hết hạn (TTL)

1. Kiểm tra TTL của CNAME record (nếu còn):
   ```bash
   dig gba.terracam.space CNAME +noall +answer
   ```
   
2. Đợi cho TTL hết hạn (thường là 3600 giây = 1 giờ)

3. Sau đó kiểm tra lại:
   ```bash
   dig gba.terracam.space CNAME +short
   ```
   Phải trả về rỗng (không có CNAME)

### Giải pháp 2: Xóa file CNAME tạm thời và thêm lại

Thử xóa file CNAME khỏi repository, đợi GitHub xóa domain, rồi thêm lại:

```bash
# Xóa CNAME
git rm CNAME
git commit -m "Temporarily remove CNAME to reset domain verification"
git push

# Đợi 5-10 phút

# Thêm lại CNAME
echo "gba.terracam.space" > CNAME
git add CNAME
git commit -m "Re-add CNAME for custom domain"
git push
```

Sau đó vào GitHub Settings → Pages và thêm lại domain.

### Giải pháp 3: Kiểm tra DNS provider settings

Đảm bảo trong DNS provider của bạn:
- ✅ **KHÔNG CÓ** CNAME record cho `gba`
- ✅ **CHỈ CÓ** 4 A records:
  - 185.199.108.153
  - 185.199.109.153
  - 185.199.110.153
  - 185.199.111.153

### Giải pháp 4: Thử dùng www subdomain

Nếu vẫn không được, thử cấu hình `www.gba.terracam.space`:

1. Thêm CNAME record cho `www`:
   ```
   Type: CNAME
   Name: www
   Value: Ynsuper-Organization.github.io.
   ```

2. Cập nhật file CNAME:
   ```
   www.gba.terracam.space
   ```

3. Thêm domain `www.gba.terracam.space` trong GitHub Settings

## 🔍 Kiểm tra DNS từ nhiều locations:

```bash
# Google DNS
dig @8.8.8.8 gba.terracam.space CNAME +short

# Cloudflare DNS
dig @1.1.1.1 gba.terracam.space CNAME +short

# OpenDNS
dig @208.67.222.222 gba.terracam.space CNAME +short
```

Tất cả phải trả về rỗng (không có CNAME).

## ⏱️ Thời gian chờ:

- DNS cache TTL: Thường 1 giờ (3600 giây)
- Sau khi xóa CNAME: Đợi ít nhất 1 giờ
- Sau đó thử verify lại trên GitHub

