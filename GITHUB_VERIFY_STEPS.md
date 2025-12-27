# ✅ DNS đã đúng - Hướng dẫn verify domain trên GitHub

## ✅ Trạng thái DNS:
- ✅ 4 A records đã được cấu hình đúng
- ✅ Không còn CNAME record
- ✅ File CNAME trong repository đúng: `gba.terracam.space`

## 🔧 Các bước để GitHub verify domain:

### Bước 1: Xóa domain khỏi GitHub Settings

1. Vào: **https://github.com/Ynsuper-Organization/terra-gba/settings/pages**
2. Scroll xuống phần **"Custom domain"**
3. Nếu thấy `gba.terracam.space`:
   - Click vào nút **X** (xóa) bên cạnh domain
   - Hoặc uncheck domain
   - Click **"Save"** (nếu có)
4. **Đợi 5 phút** để GitHub xóa domain hoàn toàn

### Bước 2: Thêm lại domain

1. Vẫn trong Settings → Pages
2. Trong ô **"Custom domain"**, nhập: `gba.terracam.space`
3. Click **"Save"**
4. GitHub sẽ tự động bắt đầu verify DNS

### Bước 3: Đợi GitHub verify

GitHub sẽ:
1. Query DNS từ nhiều locations
2. Kiểm tra 4 A records
3. Verify domain
4. Cấp SSL certificate (5-30 phút)

**Thời gian chờ:** 10-30 phút

### Bước 4: Kiểm tra trạng thái

Sau khi thêm domain, bạn sẽ thấy:
- ⏳ "Checking DNS..." (đang verify)
- ✅ Green checkmark (verify thành công)
- ❌ Red X (verify thất bại - cần kiểm tra lại DNS)

### Bước 5: Bật Enforce HTTPS

Sau khi verify thành công (có green checkmark):
1. Check vào **"Enforce HTTPS"**
2. Click **"Save"**

## 🔍 Nếu vẫn báo lỗi sau 30 phút:

### Thử lại từ đầu:

1. **Xóa domain** khỏi GitHub Settings
2. **Đợi 10 phút**
3. **Kiểm tra DNS** một lần nữa:
   ```bash
   ./verify_dns.sh
   ```
   Phải thấy:
   - ✅ 4 A records
   - ✅ Không có CNAME

4. **Thêm lại domain** trong GitHub Settings
5. **Đợi 30 phút**

### Kiểm tra DNS từ nhiều locations:

GitHub có thể query DNS từ các locations khác nhau. Đảm bảo tất cả đều trả về đúng:

```bash
# Google DNS
dig @8.8.8.8 gba.terracam.space A +short

# Cloudflare DNS  
dig @1.1.1.1 gba.terracam.space A +short

# OpenDNS
dig @208.67.222.222 gba.terracam.space A +short
```

Tất cả phải trả về **4 IP addresses**:
- 185.199.108.153
- 185.199.109.153
- 185.199.110.153
- 185.199.111.153

## ⚠️ Lưu ý quan trọng:

1. **KHÔNG** thêm/xóa domain nhiều lần trong thời gian ngắn
2. **Đợi đủ thời gian** (ít nhất 30 phút) trước khi thử lại
3. **Đảm bảo DNS đã propagate** hoàn toàn (có thể mất 1 giờ)
4. File **CNAME** trong repository phải có: `gba.terracam.space`

## 📞 Nếu vẫn không được:

Nếu sau 1 giờ vẫn báo lỗi, có thể:
1. DNS provider có vấn đề
2. GitHub đang gặp sự cố
3. Cần liên hệ GitHub Support

Nhưng thông thường, sau khi DNS đúng và xóa/thêm lại domain, GitHub sẽ verify thành công trong vòng 30 phút.

