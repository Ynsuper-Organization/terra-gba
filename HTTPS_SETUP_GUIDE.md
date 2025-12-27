# 🔒 Hướng dẫn bật HTTPS cho GitHub Pages (theo tài liệu chính thức)

Theo [tài liệu GitHub](https://docs.github.com/en/pages/getting-started-with-github-pages/securing-your-github-pages-site-with-https):

## ✅ Về HTTPS và GitHub Pages

- ✅ **Tất cả GitHub Pages sites** đều hỗ trợ HTTPS, kể cả custom domain
- ✅ GitHub tự động cấp SSL certificate qua **Let's Encrypt**
- ✅ HTTPS enforcement tự động redirect HTTP → HTTPS

## 🔧 Cách bật HTTPS (Enforce HTTPS)

### Bước 1: Vào Settings
1. Vào repository: **https://github.com/Ynsuper-Organization/terra-gba**
2. Click **Settings** (tab ở trên)
3. Trong sidebar, click **Pages**

### Bước 2: Bật Enforce HTTPS
1. Trong phần **"GitHub Pages"**
2. Check vào **"Enforce HTTPS"**
3. GitHub sẽ tự động redirect tất cả HTTP requests sang HTTPS

## ⚠️ Lưu ý quan trọng:

### 1. Domain phải < 64 ký tự
Theo RFC3280, domain name phải **< 64 ký tự** để certificate được tạo thành công.

**Kiểm tra:**
- `gba.terracam.space` = 18 ký tự ✅ (OK)

### 2. DNS phải được cấu hình đúng

Theo tài liệu GitHub, cho **subdomain** (như `gba.terracam.space`):

| Scenario | DNS Type | DNS Name | DNS Value |
|-----------|----------|----------|-----------|
| Subdomain | CNAME | gba.terracam.space | Ynsuper-Organization.github.io |

**Tuy nhiên**, bạn đang dùng **A records** (cũng được chấp nhận):
- ✅ 4 A records: 185.199.108.153, 185.199.109.153, 185.199.110.153, 185.199.111.153

### 3. Quá trình cấp SSL certificate

Khi bạn set hoặc change custom domain:
1. GitHub tự động kiểm tra DNS
2. Nếu DNS đúng → GitHub queue job để request TLS certificate từ Let's Encrypt
3. Khi nhận được certificate → GitHub tự động upload lên servers
4. Khi hoàn tất → Green checkmark xuất hiện

**Thời gian:** Có thể mất vài phút đến vài giờ

## 🔧 Troubleshooting: "Certificate not yet created"

Nếu sau vài phút vẫn chưa có certificate:

1. Click **"Remove"** bên cạnh custom domain
2. Gõ lại domain name: `gba.terracam.space`
3. Click **"Save"** lại
4. Điều này sẽ cancel và restart quá trình cấp certificate

## 🔍 Kiểm tra DNS configuration

Theo tài liệu, các records sau có thể **ngăn cản** HTTPS certificate được tạo:

- ❌ Extra A, AAAA, ALIAS, ANAME records với `@` host
- ❌ CNAME records trỏ đến www subdomain hoặc custom subdomain khác

**Kiểm tra cho gba.terracam.space:**
```bash
# Chỉ nên có 4 A records cho subdomain
dig gba.terracam.space A +short

# Không nên có CNAME (trừ khi dùng CNAME thay vì A records)
dig gba.terracam.space CNAME +short
```

## 🔄 Resolving Mixed Content

Nếu bật HTTPS nhưng website vẫn load assets qua HTTP → **Mixed Content**

### Cách sửa:
1. Tìm tất cả `http://` trong HTML files
2. Đổi thành `https://`

### Các vị trí thường gặp:
- **CSS:** Trong `<head>` section
- **JavaScript:** Trong `<head>` hoặc trước `</body>`
- **Images:** Trong `<body>` section

### Ví dụ:
```html
<!-- ❌ HTTP -->
<link rel="stylesheet" href="http://example.com/css/main.css">
<script src="http://example.com/js/main.js"></script>
<img src="http://example.com/logo.jpg">

<!-- ✅ HTTPS -->
<link rel="stylesheet" href="https://example.com/css/main.css">
<script src="https://example.com/js/main.js"></script>
<img src="https://example.com/logo.jpg">
```

## 📋 Checklist để bật HTTPS:

- [ ] Domain < 64 ký tự ✅ (`gba.terracam.space` = 18 ký tự)
- [ ] DNS đã được cấu hình đúng ✅ (4 A records)
- [ ] Custom domain đã được thêm trong GitHub Settings
- [ ] Đã đợi GitHub verify domain (có green checkmark)
- [ ] Đã đợi GitHub cấp SSL certificate (có thể mất vài giờ)
- [ ] Bật "Enforce HTTPS" trong Settings → Pages
- [ ] Kiểm tra website: https://gba.terracam.space

## 🎯 Các bước thực hiện:

1. **Đảm bảo DNS đúng:**
   ```bash
   ./verify_dns.sh
   ```

2. **Vào GitHub Settings → Pages:**
   - Đảm bảo domain `gba.terracam.space` đã được thêm
   - Đợi green checkmark xuất hiện

3. **Đợi SSL certificate được cấp:**
   - Có thể mất vài phút đến vài giờ
   - Nếu lâu quá, thử Remove và thêm lại domain

4. **Bật Enforce HTTPS:**
   - Check vào "Enforce HTTPS"
   - Click Save

5. **Kiểm tra:**
   - Truy cập: https://gba.terracam.space
   - Phải thấy green lock icon trong trình duyệt

## 📚 Tham khảo:

- [GitHub Docs: Securing your GitHub Pages site with HTTPS](https://docs.github.com/en/pages/getting-started-with-github-pages/securing-your-github-pages-site-with-https)
- [GitHub Docs: Troubleshooting custom domains](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/troubleshooting-a-custom-domain)

