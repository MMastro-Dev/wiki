# Wyse 5070 Thin Client Conversion

**Goal:** Strip the Wyse 5070 to a gateway-only machine after all services have migrated to the NAS.
**Created:** 2026-05-27
**Status:** not-started

> Depends on Phase 2 (NAS build and service migration) being complete.

---

## Steps

- [ ] **T3.1** Verify gateway services (Caddy, AdGuard, oauth2-proxy, Pocket ID) are working after NAS migration.
- [ ] **T3.2** Deploy Netdata on thin client.
- [ ] **T3.3** Deploy Uptime Kuma on thin client.
- [ ] **T3.4** Deploy Loki on thin client. Configure storage to NAS via NFS.
- [ ] **T3.5** Deploy Promtail on thin client.
- [ ] **T3.6** Reclaim SSD space: remove old application data and Docker images. Run `docker system prune`.
- [ ] **T3.7** Set up weekly cron: `docker system prune -af --filter "until=168h"`.
- [ ] **T3.8** Remove USB dock from Wyse (HDDs are now in NAS). Retire the dock.

---

## Notes

- Promtail on the AI server (S1.19) can also be pointed at Loki once T3.4 is complete.
- The Wyse runs only: Caddy, AdGuard Home, oauth2-proxy, Pocket ID, Netdata, Uptime Kuma, Loki, Promtail.
- See [notes/thin-client-and-nas.md](../thin-client-and-nas.md) for the measurement-first RAM upgrade plan (do not buy RAM before collecting baseline data).
