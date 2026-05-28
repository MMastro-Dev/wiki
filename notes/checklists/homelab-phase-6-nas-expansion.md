# NAS Storage Expansion

**Goal:** Add SnapRAID parity to the NAS for redundancy and optionally upgrade RAM for ZFS.
**Created:** 2026-05-27
**Status:** not-started

> Optional, deferred. Begin only when the NAS has been running stably and a good deal appears on a parity drive.

---

## Steps

- [ ] **E6.1** Purchase a 4TB+ drive for the free NAS bay (parity disk).
- [ ] **E6.2** Install SnapRAID. Configure parity schedule (nightly or weekly).
- [ ] **E6.3** *(Future)* Upgrade NAS RAM to 16GB+ and evaluate migrating from mergerfs+ext4 to ZFS.

---

## Notes

- Parity adds redundancy but is not a backup. Maintain the existing backup strategy.
- RAM upgrade (E6.3) is only worth evaluating if ZFS ARC hit ratio drops below 80% under real usage — see the measurement plan in [notes/thin-client-and-nas.md](../thin-client-and-nas.md).
