class HarfSayaci:
    def __init__(self):
        self.sesli_harfler = "aeıioöuü"
        self.sayac = 0

    def kelime_sor(self):
        return input("Bir kelime giriniz: ").lower()
    
    def seslidir(self, harf):
        return harf in self.sesli_harfler
    
    def artir(self):
        for harf in self.kelime:
            if self.seslidir(harf):
                self.sayac += 1
        return self.sayac
    
    def ekrana_goster(self):
        sesli_harf_sayisi = self.artir()
        mesaj = f"{self.kelime} kelimesinde {sesli_harf_sayisi} sesli harf vardır"
        print(mesaj)

    def calistir(self):
        self.kelime = self.kelime_sor()
        self.ekrana_goster()

if __name__ == '__main__':
    harfsay = HarfSayaci()
    print(harfsay)
    harfsay.calistir()