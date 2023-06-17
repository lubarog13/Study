struct Unit {
    Unit(unitid id, int hp): id_(id), hp_(hp) {}
    virtual unitid id() const { return id_; }
    virtual int hp() const {return hp_;}
    private:
        unitid id_;
        int hp_;
};

struct Elf:     Unit {};
struct Archer:  Unit{};

//struct Elf : virtual Unit {};
//struct Archer: virtual Unit {};


struct ElfArcher: Elf, Archer {
    unitid id() const {return Elf::id();}
    int hp() const {return Elf::hp();}
};

// base указывает на экземпляр Base, соответствующий D1
// нужно вернуть указатель на экземпляр Base, соответствующий D2
Base const * D1BaseToD2Base( Base const * base )
{
    D1* x = (D1*)base;
    D3* y = (D3*)x;
    D2* z = (D2*)y;
    Base* sbase = (Base*)z;
    return sbase;
}

// __getUnitPtr__() - служебный виртуальный метод