#!/usr/bin/env python3
import sys, struct

pid = int(sys.argv[1])
PAGE = 4096
nomeLib = "libmensagem"

print("Endereço Virtual\t Page Frame Number (Número do Frame)\n Endereço Físico")

with open(f"/proc/{pid}/maps") as maps, open(f"/proc/{pid}/pagemap", "rb") as pm:
    for line in maps:
        if nomeLib not in line:
            continue
        faixa, perms = line.split()[:2]
        ini, fim = [int(x, 16) for x in faixa.split("-")]
        print(f"\n{line.strip()}")
        for vaddr in range(ini, fim, PAGE):
            pm.seek((vaddr // PAGE) * 8)
            entrada = struct.unpack("<Q", pm.read(8))[0]
            presente = (entrada >> 63) & 1
            if presente:
                pfn = entrada & ((1 << 55) - 1)
                print(f"  virt 0x{vaddr:x} -> PFN 0x{pfn:x} (fís 0x{pfn*PAGE:x})")
            else:
                print(f"  virt 0x{vaddr:x} -> não presente na DRAM")