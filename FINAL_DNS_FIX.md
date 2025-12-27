# 🔴 GIẢI PHÁP CUỐI CÙNG - Xóa CNAME Record

## ❌ Vấn đề hiện tại:
- ✅ Đã có đủ 4 A records
- ❌ VẪN CÒN CNAME record → GitHub bị confuse!

## ✅ Giải pháp:

### Bước 1: XÓA CNAME record trong DNS provider

Trong DNS provider của bạn, **XÓA HOÀN TOÀN** record sau:
```
Type: CNAME
Name: gba
Value: ynsuper-organization.github.io.
```

**QUAN TRỌNG:** Chỉ giữ lại 4 A records, KHÔNG có CNAME!

### Bước 2: Đợi DNS propagate (10-30 phút)

Sau khi xóa CNAME, đợi 10-30 phút để DNS propagate.

### Bước 3: Kiểm tra lại DNS

Chạy lệnh:
```bash
./verify_dns.sh
```

Phải thấy:
- ✅ 4 A records
- ✅ Không có CNAME

### Bước 4: Xóa và thêm lại domain trên GitHub

1. Vào: https://github.com/Ynsuper-Organization/terra-gba/settings/pages
2. Trong phần "Custom domain":
   - **XÓA** domain `gba.terracam.space` (click vào X hoặc uncheck)
   - **Đợi 2-3 phút**
   - **THÊM LẠI** domain: `gba.terracam.space`
   - Click "Save"
3. Đợi GitHub xác minh (5-10 phút)

### Bước 5: Nếu vẫn lỗi - Thử cách khác

Nếu sau 30 phút vẫn lỗi, thử:

1. **Xóa file CNAME tạm thời:**
   ```bash
   git rm CNAME
   git commit -m "Temporarily remove CNAME"
   git push
   ```

2. **Đợi 5 phút**

3. **Thêm lại file CNAME:**
   ```bash
   echo "gba.terracam.space" > CNAME
   git add CNAME
   git commit -m "Re-add CNAME"
   git push
   ```

4. **Vào GitHub Settings → Pages và thêm lại domain**

## 🔍 Tại sao phải xóa CNAME?

GitHub Pages yêu cầu:
- **CHỈ** dùng A records cho subdomain
- **KHÔNG** được dùng CNAME khi đã có A records
- Có cả hai sẽ gây conflict và GitHub không thể verify

## ⚠️ Lưu ý cuối cùng

- Đảm bảo **CHỈ CÓ** 4 A records, **KHÔNG CÓ** CNAME
- File CNAME trong repository vẫn phải có: `gba.terracam.space`
- Đợi đủ thời gian để DNS propagate trước khi verify lại

