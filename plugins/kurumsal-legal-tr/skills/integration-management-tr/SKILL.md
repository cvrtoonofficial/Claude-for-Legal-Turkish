---
name: integration-management-tr
description: >
  M&A işleminin kapanış sonrası entegrasyonunu takip eder — sözleşme devri, müşteri-
  tedarikçi bildirimleri, banka yetki güncellemeleri, KVKK uyumu konsolidasyonu, vergi
  birleşmesi, TTK m.396 birleşme/bölünme süreçleri. Tetikleyiciler: "post-close",
  "kapanış sonrası", "integration", "şirket entegrasyonu", "konsolidasyon".
argument-hint: "[--phase 30|60|90|180|365 | --task-status]"
---

# /integration-management-tr

## Aşamalı entegrasyon takvimi

### Faz 1 — Acil (T+0 → T+30 gün)

| ✓ | Madde | Mevzuat | Sorumlu |
|---|-------|---------|---------|
| ☐ | Banka hesap yetki değişiklikleri | Banka iç prosedürü | finans |
| ☐ | İmza sirküleri yenileme | Noterlik | hukuk |
| ☐ | KEP elektronik tebligat adresi güncellemesi | Tebligat K. | hukuk |
| ☐ | SGK işveren / temsilci güncelleme | 5510 | İK |
| ☐ | VERBİS Veri Sorumlusu temsilcisi güncelleme | KVKK m.16 | hukuk + DPO |
| ☐ | MERSİS güncellemesi (varsa) | TTK m.24 | hukuk |
| ☐ | Müşteri-tedarikçi bildirimi (change-of-control gerektirenler) | Sözleşme bazlı | satış + hukuk |
| ☐ | Çalışan iletişimi (TTK m.178 — birleşme/devir bilgilendirme) | İK |

### Faz 2 — Kısa vade (T+30 → T+90 gün)

| ✓ | Madde | Mevzuat | Sorumlu |
|---|-------|---------|---------|
| ☐ | Sözleşme devir (assignment) kararları (BK m.83) | BK 6098 | hukuk |
| ☐ | IP/marka/patent devirleri TPMK'ya tescil | SMK 6769 | hukuk |
| ☐ | FSEK telif devirleri yazılı şekil + bandrol | FSEK m.52 | hukuk |
| ☐ | Sigortacı bildirimi + poliçe güncelleme | TBK m.1421 | finans |
| ☐ | Vergi mahsubu birleşmesi | VUK 213 | mali müşavir |
| ☐ | KVKK aydınlatma metni revizyonu | KVKK m.10 | hukuk + DPO |
| ☐ | İç politika harmonizasyonu (uzaktan çalışma, mobbing, etik) | 4857 İK + İç Yönetmelik | İK + hukuk |

### Faz 3 — Orta vade (T+90 → T+180 gün)

| ✓ | Madde | Mevzuat | Sorumlu |
|---|-------|---------|---------|
| ☐ | Personel re-organizasyon / fazlalık yönetimi (4857 m.18-22) | 4857 | İK + hukuk |
| ☐ | IT sistem entegrasyonu (KVKK güvenlik tedbirleri uyumu) | KVKK m.12 | IT + hukuk |
| ☐ | Banka kredi sözleşmelerinde kontrol değişikliği bildirimi | Sözleşme bazlı | finans |
| ☐ | Veri envanteri konsolidasyonu | KVKK m.16 | DPO |
| ☐ | Üçüncü taraf veri işleyici (DPA) yenileme | KVKK m.12 + GDPR m.28 | hukuk + DPO |

### Faz 4 — Uzun vade (T+180 → T+365 gün)

| ✓ | Madde | Mevzuat | Sorumlu |
|---|-------|---------|---------|
| ☐ | Yıllık olağan GK (TTK m.409) | TTK | hukuk |
| ☐ | Konsolide finansal tablolar (TTK m.514) | TTK | finans |
| ☐ | Bağımsız denetim atama (TTK m.397/4) | TTK | finans |
| ☐ | Yıllık faaliyet raporu — birleşme bilgisi (TTK m.516) | TTK | hukuk + finans |
| ☐ | Müşteri-tedarikçi sözleşmeleri sona ermeye yakın → yenileme/yeniden müzakere | TBK | satış + hukuk |
| ☐ | Çalışan kıdem hesaplaması birleşme öncesi süreyle birlikte | 1475 m.14 | İK |

## Sözleşme devri (assignment) yönetimi

Plugin entegrasyon sırasında **change-of-control klozlu sözleşmeleri** önceliklendirir:

1. Bildirim süresi olan sözleşmeler (otomatik fesih riski)
2. Münhasır lisanslar (FSEK + SMK)
3. Yabancı tahkim klozlu sözleşmeler (MÖHUK m.47 + Rome I uygulanabilirliği)
4. Tüketici sözleşmeleri (TKHK + KVKK uyumu)

Her sözleşme için:
- Bildirim taslağı (KEP + iadeli taahhütlü)
- Yeniden müzakere şartları (varsa)
- Fesih hakkı doğacaksa hangi tarihten
- BK m.83 onay gerekli mi (kişiye bağlı haklar)

## TTK m.396 birleşme/bölünme süreçleri

Eğer entegrasyon **şirket birleşmesi** veya **bölünmesi** ile yapılacaksa:

- TTK m.134-158 (Birleşme)
- TTK m.159-179 (Bölünme)
- TTK m.180-194 (Tür değiştirme)
- Birleşme/bölünme sözleşmesi taslağı
- GK kararları
- Alacaklılara çağrı + 3 ay alacak teminat süresi (TTK m.157)
- Ticaret Sicil tescili + ilan

## Cross-plugin handoff

- Açık dava → `turk-hukuk-legal:dilekce-ihtarname`
- Yargı yolu seçimi → `turk-hukuk-legal:yargi-yolu-secimi`
- Süre hesabı → `turk-hukuk-legal:siure-hesap-motoru`
- KVKK konsolidasyonu → `ai-governance-vatandas-legal`
- Final .docx → `turk-hukuk-legal:docx-uretici`

## MCP kaynakları

- TTK birleşme/bölünme: `mevzuat_mcp:search_within_kanun`
- Yargıtay birleşme emsali: `yargi_mcp:search_bedesten_unified`
- Rekabet Kurulu post-merger: `yargi_mcp:search_rekabet_kurumu_decisions`

## Final çıktı

- `outputs/integration-tracker-YYYY-MM-DD.yaml`
- `outputs/integration-status-YYYY-MM-DD.md` (faz bazlı durum raporu)
- `outputs/assignment-notifications/` (her sözleşme için bildirim taslağı)
