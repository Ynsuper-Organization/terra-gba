# ✅ DNS đã đúng - Bước cuối: Verify Domain trên GitHub

## ✅ Trạng thái hiện tại:
- ✅ 4 A records đã được cấu hình đúng
- ✅ Không còn CNAME record
- ✅ File CNAME trong repository đã đúng
- ⚠️  GitHub chưa verify domain và chưa cấp SSL certificate

## 🔧 Các bước để GitHub verify domain:

### Bước 1: Xóa domain khỏi GitHub Settings

1. Vào: https://github.com/Ynsuper-Organization/terra-gba/settings/pages
2. Trong phần "Custom domain":
   - **XÓA** domain `gba.terracam.space` (click vào nút X hoặc uncheck)
   - Click "Save" (nếu có)
   - **Đợi 2-3 phút**

### Bước 2: Thêm lại domain

1. Vẫn trong Settings → Pages
2. Trong ô "Custom domain", nhập: `gba.terracam.space`
3. Click "Save"
4. GitHub sẽ tự động bắt đầu verify domain

### Bước 3: Đợi GitHub verify và cấp SSL

- GitHub sẽ tự động:
  1. Verify DNS records (đã đúng rồi)
  2. Cấp SSL certificate (có thể mất 5-30 phút)
  3. Enable HTTPS

- Bạn sẽ thấy:
  - ✅ Green checkmark khi verify thành công
  - ✅ "Enforce HTTPS" checkbox sẽ xuất hiện và có thể bật

### Bước 4: Bật Enforce HTTPS (sau khi verify)

1. Sau khi domain được verify (có green checkmark)
2. Check vào "Enforce HTTPS"
3. Click "Save"

### Bước 5: Kiểm tra website

Sau khi hoàn tất, website sẽ có sẵn tại:
- ✅ https://gba.terracam.space

## ⏱️ Thời gian chờ:

- DNS verification: Ngay lập tức (DNS đã đúng)
- SSL certificate: 5-30 phút (GitHub tự động cấp)
- Tổng thời gian: **10-30 phút**

## 🔍 Kiểm tra tiến trình:

Sau khi thêm lại domain, bạn có thể:
1. Refresh trang Settings → Pages
2. Xem trạng thái verify (sẽ có green checkmark khi thành công)
3. Kiểm tra website: https://gba.terracam.space

## ⚠️ Lưu ý:

- **KHÔNG** thêm domain nhiều lần trong thời gian ngắn
- Đợi đủ thời gian để GitHub xử lý
- Nếu sau 1 giờ vẫn chưa verify, thử xóa và thêm lại một lần nữa

