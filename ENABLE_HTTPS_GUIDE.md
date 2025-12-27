# 🔒 Hướng dẫn bật HTTPS cho gba.terracam.space

## ✅ Trạng thái hiện tại:
- ✅ Website đang hoạt động: **http://gba.terracam.space**
- ❌ HTTPS chưa hoạt động: **https://gba.terracam.space** (chưa có SSL certificate)

## 🔍 Nguyên nhân:
GitHub chưa verify domain và chưa cấp SSL certificate cho `gba.terracam.space`.

## ✅ Giải pháp:

### Bước 1: Đảm bảo DNS đã đúng

Chạy lệnh kiểm tra:
```bash
./verify_dns.sh
```

Phải thấy:
- ✅ 4 A records
- ✅ Không có CNAME

### Bước 2: Verify domain trên GitHub

1. Vào: **https://github.com/Ynsuper-Organization/terra-gba/settings/pages**

2. Trong phần **"Custom domain"**:
   - Nếu chưa có domain, thêm: `gba.terracam.space`
   - Nếu đã có domain nhưng báo lỗi, thử:
     - **Xóa** domain
     - **Đợi 5 phút**
     - **Thêm lại** domain: `gba.terracam.space`
   - Click **"Save"**

3. GitHub sẽ tự động:
   - Verify DNS records
   - Cấp SSL certificate (có thể mất **vài giờ đến 24 giờ**)

### Bước 3: Đợi GitHub cấp SSL certificate

- **Thời gian:** 1-24 giờ (thường là 1-3 giờ)
- GitHub sẽ tự động cấp SSL certificate qua Let's Encrypt
- Bạn sẽ thấy green checkmark khi verify thành công

### Bước 4: Bật Enforce HTTPS

Sau khi domain được verify và có SSL certificate:

1. Vào lại: **https://github.com/Ynsuper-Organization/terra-gba/settings/pages**

2. Trong phần **"Custom domain"**:
   - Phải thấy green checkmark ✅
   - Check vào **"Enforce HTTPS"**
   - Click **"Save"**

3. Sau khi bật, tất cả traffic HTTP sẽ tự động redirect sang HTTPS

## 🔍 Kiểm tra tiến trình:

### Kiểm tra trên GitHub:
1. Vào Settings → Pages
2. Xem trạng thái domain:
   - ⏳ "Checking DNS..." = Đang verify
   - ✅ Green checkmark = Verify thành công
   - ❌ Red X = Verify thất bại

### Kiểm tra SSL certificate:
```bash
# Kiểm tra SSL certificate
openssl s_client -connect gba.terracam.space:443 -servername gba.terracam.space < /dev/null 2>/dev/null | openssl x509 -noout -dates
```

Hoặc dùng trình duyệt truy cập: https://gba.terracam.space

## ⚠️ Lưu ý quan trọng:

1. **Đợi đủ thời gian:** SSL certificate có thể mất đến 24 giờ để được cấp
2. **DNS phải đúng:** GitHub cần verify DNS trước khi cấp SSL
3. **Không thêm/xóa domain nhiều lần:** Điều này có thể làm chậm quá trình cấp SSL
4. **File CNAME phải đúng:** File CNAME trong repository phải chứa: `gba.terracam.space`

## 🔧 Nếu sau 24 giờ vẫn chưa có HTTPS:

### Thử các bước sau:

1. **Kiểm tra lại DNS:**
   ```bash
   ./verify_dns.sh
   ```

2. **Xóa và thêm lại domain trên GitHub:**
   - Xóa domain
   - Đợi 10 phút
   - Thêm lại domain
   - Đợi 24 giờ

3. **Kiểm tra CAA records (nếu có):**
   ```bash
   dig gba.terracam.space CAA +short
   ```
   Nếu có CAA records, có thể cần xóa tạm thời

4. **Liên hệ GitHub Support:**
   Nếu vẫn không được sau 24 giờ, có thể cần liên hệ GitHub Support

## 📋 Checklist:

- [ ] DNS đã được cấu hình đúng (4 A records, không có CNAME)
- [ ] Domain đã được thêm trong GitHub Settings → Pages
- [ ] Domain đã được verify (có green checkmark)
- [ ] Đã đợi ít nhất 1 giờ sau khi verify
- [ ] Đã bật "Enforce HTTPS" trong GitHub Settings
- [ ] Website hoạt động với HTTPS: https://gba.terracam.space

## 🎯 Kết quả mong đợi:

Sau khi hoàn tất:
- ✅ **http://gba.terracam.space** → Tự động redirect sang HTTPS
- ✅ **https://gba.terracam.space** → Hoạt động với SSL certificate
- ✅ Green lock icon trong trình duyệt

