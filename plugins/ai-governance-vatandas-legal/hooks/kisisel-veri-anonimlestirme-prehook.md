# Hook: kisisel-veri-anonimlestirme-prehook

**Tip:** UserPromptSubmit (PreToolUse de olabilir)  
**Tetik:** Her kullanıcı mesajı eklentinin bir skill'ine iletilmeden ÖNCE  
**Hukuki temel:** KVKK m.4 (genel ilkeler — sınırlı amaç, asgari işleme), KVKK m.5 (rıza), TCK m.135 (kişisel verinin hukuka aykırı işlenmesi suçu), TCK m.136 (verme/yayma)

## Amaç

Vatandaş kendi davasını yazarken farkında olmadan **kendi veya üçüncü kişilerin kişisel verilerini** dış AI sağlayıcısına gönderir. Bu eklenti bu tuzağa karşı **birinci savunma hattı** olarak konumlanır.

> Örnek tipik durumlar (placeholder ile, gerçek değer yok):
> - "Mehmet Ahmet, \[11 haneli TC no\], \[TR cep no\]..." → ChatGPT'ye yapıştırma
> - "\[TR + 24 hane IBAN\]" → Banka IBAN'ı dilekçede
> - "Doğum \[GG.AA.YYYY\], kan grubu O+, X hastanesi raporu..." → tıbbi veri AI'a
> - "Komşum Y'nin telefon numarası \[TR cep no\]..." → 3. kişinin verisi
>
> *Yukarıdaki örneklerde gerçek değil placeholder kullanıldı — hook'un kendi belgesinin tarama tetiklememesi için.*

## Algılama paternleri

Hook aşağıdaki kalıpları arar:

| Veri tipi | Regex / pattern | KVKK statüsü |
|---|---|---|
| TC kimlik no | `\b[1-9][0-9]{10}\b` (11 hane, ilk hane sıfır olmamalı, son hane TC algoritması ile teyit) | m.6 özel nitelikli (kimlik) |
| IBAN | `TR[0-9]{2}\s?[0-9]{4}\s?[0-9]{4}\s?[0-9]{4}\s?[0-9]{4}\s?[0-9]{4}\s?[0-9]{2}` | m.3 kişisel veri |
| Telefon (TR) | `(\+90\|0)?\s?5[0-9]{2}\s?[0-9]{3}\s?[0-9]{2}\s?[0-9]{2}` | m.3 kişisel veri |
| E-posta | RFC 5322 yaklaşık | m.3 kişisel veri |
| Tarih (doğum şeklinde) | `\b[0-3][0-9][./-][0-1][0-9][./-]19[0-9]{2}\b` | m.3 (çoğunlukla) |
| Plaka | `\b[0-9]{2}\s?[A-Z]{1,3}\s?[0-9]{2,4}\b` | m.3 |
| Sağlık verisi anahtar kelimeleri | "hasta", "tanı", "ICD", "reçete", "hastane", "kan grubu" | m.6 özel nitelikli |
| Adli sicil anahtar kelimeleri | "savcılık dosya no", "soruşturma no", "iddianame" | m.6 özel nitelikli |
| Bankacılık | "hesap numarası", "kart numarası", "CVV" | m.3 kişisel veri + finansal |

## Davranış

Eşleşme bulunursa kullanıcıya **kesinlikle bloklayıcı olmayan** bir uyarı verir:

```
⚠️ KİŞİSEL VERİ UYARISI

Mesajınızda şu tipte kişisel veri tespit edildi:
- TC kimlik no (1 adet)
- Telefon (2 adet)
- Sağlık verisi anahtar kelimeleri (3 ifade)

KVKK m.4 asgari işleme ilkesi ve TCK m.135 kişisel veri suçları nedeniyle, AI sağlayıcısına bu verileri **gerçek hâlleriyle** göndermenizi tavsiye etmiyorum.

NE YAPMAK İSTERSİNİZ?
1. [Önerilen] Anonimleştir ve devam et — TC→[TC], telefon→[telefon] olarak değişir
2. Olduğu gibi gönder — riski kabul ediyorum (örn. kendi verim, sızıntı endişem yok)
3. İptal et — mesajı yeniden yazayım
```

Yanıta göre:
- **Anonimleştir:** Veriler `[TÜR]` placeholder'ları ile değiştirilir; orijinal değer **yerel oturumda** tutulur, sonra raporlamada geri yerleştirilir
- **Olduğu gibi:** Uyarı kapatılır, kullanıcı sorumluluk üstlenir, mesaj iletilir
- **İptal:** Kullanıcı yeniden yazar

## İstisna kuralları

- Kullanıcının **kendi kişisel politikasında** beyaz listeye aldığı veri tipleri uyarı vermez (kisisel-ai-politika ile entegre)
- Anonimleştirilmiş şablonlarda placeholder'lar yer alıyorsa (örn. `[TC]`, `[isim]`) sessiz geçer
- Avukat irtibatı tanımlanmışsa ve mesaj sadece avukatla paylaşılacaksa uyarı seviyesi düşer (yine de gözden geçirilir)

## Hukuki temel detayları

**KVKK m.4(2):** *"Kişisel veriler, ancak bu Kanunda ve diğer kanunlarda öngörülen usul ve esaslara uygun olarak işlenebilir."*

**KVKK m.5:** İşleme rızası (açık rıza veya istisna). AI sağlayıcısı 3. taraf işleyici olduğunda **veri sorumlusu siz** (kendi verilerinizde) veya **3. kişinin verilerinde rızasız işleme** ise siz **veri sorumlusu sıfatıyla** sorumlu olabilirsiniz.

**TCK m.135/1:** *"Hukuka aykırı olarak kişisel verileri kaydeden kimseye bir yıldan üç yıla kadar hapis cezası verilir."*

**TCK m.136/1:** *"Kişisel verileri, hukuka aykırı olarak bir başkasına veren, yayan veya ele geçiren kişi, iki yıldan dört yıla kadar hapis cezası ile cezalandırılır."*

Bu maddelerin **vatandaşa risk** boyutu: 3. kişinin (örn. karşı tarafın, tanığın, eski sevgilinizin) verisini AI'a göndermek **TCK m.136 maddi unsurunu** oluşturabilir; özellikle bu veri sonra başka bir bağlamda yayılırsa.

## Yapılandırma

`~/.claude/plugins/config/claude-for-legal/ai-governance-legal/anonimlestirme-config.yaml`:

```yaml
enabled: true
strictness: high  # low | medium | high
auto_redact:
  - tc_kimlik
  - iban
  - kart_numarasi
warn_only:
  - telefon
  - email
  - tarih_dogum
whitelist:
  - "kendi e-postam: theakambio@gmail.com"
  - "kendi telefonum: [varsa]"
```

## Cross-skill etkisi

Tüm skill'ler bu hook'tan sonra çalışır. Eğer kullanıcı anonimleştirmeyi seçtiyse, çıktıların raporlama aşamasında orijinal değerler yerine konur (sadece kullanıcının kendi cihazında, AI'a hiç gönderilmeden).
