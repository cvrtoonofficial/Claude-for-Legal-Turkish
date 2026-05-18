---
name: tabular-review-tr
description: >
  Batch sözleşme incelemesi — N sözleşmede aynı anda M veri noktasını çıkarıp tablo
  (.xlsx) üretir. Her hücre kaynağa pin-cite'lı. Sanatçı sözleşmesi için ön-tanımlı
  9 kolon. Tetikleyiciler: "tabular review", "30 sözleşme incele", "batch review",
  "sözleşmeleri kıyasla", "change of control klozu çıkar".
argument-hint: "[--contracts <path> | --fields <kolonlar> | --preset sanatci|kurumsal|cross-border]"
---

# /tabular-review-tr

## Ne yapar

Birden çok sözleşmeyi paralel inceleyip **bir satır = bir sözleşme, bir kolon = bir veri noktası** formatında Excel grid'i üretir. Her hücre kaynak belgeye pin-cite'lı (sayfa/madde).

## Preset'ler

### 1. `sanatci` (varsayılan, müvekkil profili sanatçı/yapımcı ise)

9 kolonlu standart inceleme:

| Kolon | Açıklama |
|-------|----------|
| Doküman | Sözleşme adı / dosya yolu |
| Tarihler | İmza + yürürlük + bitiş + otomatik yenileme |
| Mali hak devri | FSEK m.48-52 — var/yok + kapsam + süre |
| Manevi hak | FSEK m.16-19 — saklı/devredilmiş/silinmiş |
| Münhasırlık | Var/yok + süre + sınırı (FSEK m.50) |
| Change of control | Var/yok + bildirim süresi |
| Tahkim/Yetki | MÖHUK m.47 — geçerli mi? Türk mahkemesi mi yabancı mı? |
| Süre/Fesih | Otomatik yenileme + fesih hakkı + cezai şart |
| Royalty | Oran + hesap yöntemi + ödeme periyodu |

### 2. `kurumsal` (KOBİ/aile şirketi profili)

| Kolon | Açıklama |
|-------|----------|
| Doküman | — |
| Taraflar | Müvekkil + karşı taraf |
| Tarihler | İmza + bitiş |
| Yıllık değer | TL eşdeğeri |
| Change of control | Var/yok |
| Devir/Atama kısıtı | BK m.83 + sözleşme klozu |
| Münhasırlık / Non-compete | Var/yok + süre |
| Garantiler | Kapsam + süre + tavan |
| Tazminat klozu | Kapsam + tavan + ön ödeme |
| Yetki / Tahkim | MÖHUK m.47 + ICC vb. |

### 3. `cross-border` (yabancı yatırımcı profili)

Kurumsal preset + ek 4 kolon:

| Ek kolon | Açıklama |
|----------|----------|
| Uygulanacak hukuk | Türk / yabancı (Rome I + MÖHUK m.24) |
| FX klozu | Hangi para birimi + dönüşüm yöntemi |
| Veri aktarımı | KVKK m.9 + GDPR Bölüm V (SCC, BCR, adequacy) |
| Sanctions klozu | OFAC, AB, BM, Türkiye listeleri |

## Custom kolonlar

Kullanıcı `--fields "kol1,kol2,kol3"` ile özel kolon belirleyebilir.

## Akış

1. Plugin sözleşme dosyalarını okur (PDF, DOCX, TXT)
2. Her sözleşme için preset/custom kolonları çıkarır
3. Belirsiz alanlar `[manuel inceleme gerekli]` etiketi alır
4. Her hücreye pin-cite (sayfa/madde) eklenir
5. Excel + Markdown çıktı

## Gap detection (eksik kategoriler)

Plugin sözleşme listesinde **eksik kategoriler** varsa raporlar:

- 30 sözleşmeden 12'sinde change-of-control klozu **yok** → "Kontrolün geçişinde bildirim yükümlülüğü kuvvetli olabilir" uyarısı
- 5 sözleşmede tahkim klozu yabancı kurum (ICC, Stockholm) — MÖHUK m.47 geçerlilik kontrolü gerekli
- 8 sözleşmede mali hak devri yer alıyor ama manevi hak saklı tutulmamış → FSEK m.16-19 risk

## Cross-plugin handoff

- Detaylı IP klozu incelemesi: `turk-hukuk-legal:fikri-haklar-klozu-inceleme`
- Sanatçı sözleşmesi derinlemesine: `turk-hukuk-legal:sanatci-sozlesme-inceleme`
- Cross-border yetki itiraz: `turk-hukuk-legal:sinirostesi-sozlesme-fesih`
- İsveçli platformlar (Amuse, Epidemic Sound, Kobalt): `swedish-music-law` skill'i

## MCP kaynakları

- FSEK / TBK / MÖHUK madde sorguları: `mevzuat_mcp:search_kanun`
- Sanatçı sözleşmesi Yargıtay emsali: `yargi_mcp:search_bedesten_unified`
- Doktrin: `literatur_mcp:search_articles`

## Final çıktı

- `outputs/tabular-review-YYYY-MM-DD.xlsx` (grid)
- `outputs/tabular-review-YYYY-MM-DD-rapor.md` (gap + öneri raporu)
- `outputs/tabular-review-pin-cites.csv` (her hücrenin kaynak referansı)
