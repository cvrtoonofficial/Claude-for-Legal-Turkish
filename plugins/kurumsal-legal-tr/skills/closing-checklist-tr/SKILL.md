---
name: closing-checklist-tr
description: >
  Türk usulü M&A kapanış checklist'i — 4 fazlı (imza öncesi, imza, kapanış, kapanış sonrası).
  Rekabet Kurulu bildirimi (Tebliğ 2010/4), Ticaret Sicil tescili (TTK m.30), MERSİS, VERBİS
  güncellemesi, sektörel onaylar (BTK/BDDK/RTÜK/EPDK), pay defteri işleme. Tetikleyiciler:
  "kapanış listesi", "closing checklist", "ne kaldı kapanışa", "TTK tescil".
argument-hint: "[--status | --add <madde> | --done <id> | --critical-path]"
---

# /closing-checklist-tr

## 4 Fazlı checklist iskeleti

### Faz 1 — İmza öncesi (Pre-signing)

| ✓ | Madde | Mevzuat | Sorumlu | Deadline |
|---|-------|---------|---------|----------|
| ☐ | Esas sözleşme tadili taslağı | TTK m.452 | [hukuk] | T-30 |
| ☐ | Hisse devri sözleşmesi taslağı | TTK m.490 (AŞ) / m.595 (Ltd) | [hukuk] | T-21 |
| ☐ | Rekabet Kurulu birleşme bildirimi (eşik aşılıyorsa) | RKHK 4054 + Tebliğ 2010/4 | [hukuk + finans] | T-14 + ön bildirim 30 gün |
| ☐ | Sektörel onaylar (BTK/BDDK/RTÜK/EPDK) | İlgili sektörel mevzuat | [hukuk] | sektöre göre |
| ☐ | KVKK uyum auditi (VERBİS, aydınlatma, açık rıza) | KVKK 6698 | [hukuk + IT] | T-14 |
| ☐ | Vergi mahsubu / TUTKAR / Vergi borcu sıfırlama | VUK 213 + 6183 | [mali müşavir] | T-7 |
| ☐ | Pay sahibi-ler-i bilgi notu (esas sözleşme yetki gerektiriyorsa) | TTK m.196 | [yatırımcı ilişkileri] | T-7 |

### Faz 2 — İmza (Signing)

| ✓ | Madde | Mevzuat | Sorumlu | Deadline |
|---|-------|---------|---------|----------|
| ☐ | Hisse devri / varlık devri sözleşmesi imza | TBK + TTK | taraflar | T |
| ☐ | Yan sözleşmeler (escrow, transition services) | TBK | taraflar | T |
| ☐ | YK / GK kararları | TTK m.390-414 | YK/GK | T |
| ☐ | Damga vergisi ödemesi (sözleşme bedeli üzerinden) | DVK | mali müşavir | T+1 |
| ☐ | KEP üzerinden taraflara imza bildirimi | Tebligat K. m.7/a | [hukuk] | T+1 |

### Faz 3 — Kapanış (Closing)

| ✓ | Madde | Mevzuat | Sorumlu | Deadline |
|---|-------|---------|---------|----------|
| ☐ | Bedel transferi (Escrow → satıcı) | TBK m.83-84 | banka | T (kapanış günü) |
| ☐ | Pay defterine işleme | TTK m.499 | [şirket sekreteri] | T |
| ☐ | Ticaret Sicil tescili (esas sözleşme + YK + ortaklık değişikliği) | TTK m.30 | TSM | T+15 |
| ☐ | Türkiye Ticaret Sicil Gazetesi ilanı | TTK m.36 | TSM | tescil sonrası |
| ☐ | MERSİS güncellemesi | TTK m.24 | online | T+15 |
| ☐ | Banka hesap yetki değişiklikleri | Banka iç prosedürü | yeni yetkili | T+1 |
| ☐ | Vergi dairesi bildirim | VUK | mali müşavir | T+10 |
| ☐ | SGK bildirimi (yeni temsilciler) | 5510 | İK | T+10 |

### Faz 4 — Kapanış sonrası (Post-closing)

| ✓ | Madde | Mevzuat | Sorumlu | Deadline |
|---|-------|---------|---------|----------|
| ☐ | VERBİS güncellemesi (Veri Sorumlusu temsilcisi değiştiyse) | KVKK m.16 + Yönetmelik | [hukuk + DPO] | T+30 |
| ☐ | İmza sirküleri yenileme | Noterlik | yeni yetkili | T+30 |
| ☐ | Yıllık faaliyet raporuna işleme | TTK m.516 | finans | bir sonraki dönem |
| ☐ | Müvekkil/yatırımcı brief | — | [hukuk] | T+7 |
| ☐ | Integration plan başlatma | — | [hukuk + ops] | T+1 |

## Komutlar

### `--status`
Tüm checklist'i durum göstergeleriyle gösterir.

### `--critical-path`
Kapanışı blokeleyebilecek maddeleri vurgular (Rekabet Kurulu, sektörel onay, vergi).

### `--add <madde>`
Yeni özel madde ekler (sektöre özel veya işleme özel).

### `--done <id>`
Maddeyi tamamlandı olarak işaretler.

## Cross-plugin handoff

- Rekabet Kurulu bildirimi → ileride `rekabet-kurulu-bildirim-tr` skill'i (v2.0)
- Süre hesaplama → `turk-hukuk-legal:siure-hesap-motoru`
- Final .docx → `turk-hukuk-legal:docx-uretici`

## MCP kaynakları

- TTK madde sorguları: `mevzuat_mcp:search_kanun`
- Rekabet Kurulu emsali: `yargi_mcp:search_rekabet_kurumu_decisions`
- Ticaret Sicil Yönetmeliği: `mevzuat_mcp:search_kurum_yonetmelik`
