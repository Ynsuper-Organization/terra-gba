# 🚨 VẤN ĐỀ: CNAME RECORD VẪN CÒN TRONG DNS!

## ❌ Phát hiện:
CNAME record vẫn còn tồn tại trong DNS:
```
gba.terracam.space.  CNAME  ynsuper-organization.github.io.
TTL: 1006 giây (còn ~16 phút)
```

## ✅ HÀNH ĐỘNG NGAY:

### Bước 1: XÓA CNAME record trong DNS Provider

Vào DNS provider của bạn (nơi quản lý terracam.space) và **XÓA HOÀN TOÀN** record:

```
Type: CNAME
Name: gba
Value: ynsuper-organization.github.io.
```

**QUAN TRỌNG:** 
- Phải xóa CNAME record này
- Chỉ giữ lại 4 A records

### Bước 2: Kiểm tra sau khi xóa

Sau khi xóa, chạy lệnh này để kiểm tra:
```bash
dig gba.terracam.space CNAME +short
```

Kết quả phải là **RỖNG** (không có output).

### Bước 3: Đợi DNS propagate

- Đợi ít nhất **30 phút** sau khi xóa CNAME
- DNS cache có thể mất 1 giờ để hết hạn hoàn toàn

### Bước 4: Xóa và thêm lại domain trên GitHub

1. Vào: https://github.com/Ynsuper-Organization/terra-gba/settings/pages
2. **XÓA** domain `gba.terracam.space` (nếu có)
3. **Đợi 5 phút**
4. **THÊM LẠI** domain: `gba.terracam.space`
5. Click "Save"

### Bước 5: Đợi GitHub verify

- GitHub sẽ tự động verify DNS
- Nếu CNAME đã được xóa hoàn toàn, verify sẽ thành công
- Thời gian: 5-30 phút

## 🔍 Kiểm tra DNS đúng:

Sau khi xóa CNAME, chạy:
```bash
./verify_dns.sh
```

Phải thấy:
- ✅ 4 A records
- ✅ Không có CNAME

## ⚠️ LƯU Ý QUAN TRỌNG:

**KHÔNG THỂ** có cả CNAME và A records cùng lúc cho cùng một subdomain!

GitHub Pages yêu cầu:
- **CHỈ** dùng A records cho subdomain
- **KHÔNG** được có CNAME record

## 📋 Checklist:

- [ ] Đã xóa CNAME record trong DNS provider
- [ ] Đã đợi 30 phút sau khi xóa
- [ ] Đã kiểm tra: `dig gba.terracam.space CNAME +short` trả về rỗng
- [ ] Đã xóa domain khỏi GitHub Settings
- [ ] Đã thêm lại domain trong GitHub Settings
- [ ] Đã đợi GitHub verify (5-30 phút)

