% Zwraca I-ty element listy Lista jako Element
ity([A | Ogon], 0, A).
ity(Lista, I, Element) :-
    [A | Ogon] = Lista,
    J is I - 1,
    ity(Ogon, J, Element).


% Sprawdza, czy element Element nalezy do listy Lista
nalezy(Element, Lista) :-
    (
        Lista == [],
        fail
    );
    (
        [A | Ogon] = Lista,
        (
            A == Element;
            nalezy(Element, Ogon)
        )
    ).


% Zwraca jako Liczba liczby calkowite pomiedzy liczba calkowita Min
% a liczba calkowita Max, wlaczajac liczby Min i Max, w kolejnosci rosnacej
liczby_pomiedzy_rosnaco(Min, Max, Liczba) :-
    (
        Min == Max,

        Liczba = Min
    );
    (
        Min =\= Max,

        (
            Liczba = Min;
            (
                Nowy_Min is Min + 1,
                liczby_pomiedzy_rosnaco(Nowy_Min, Max, Liczba)
            )
        )
    ).


% Zwraca jako Liczba liczby calkowite pomiedzy liczba calkowita Min
% a liczba calkowita Max, wlaczajac liczby Min i Max, w kolejnosci malejacej
liczby_pomiedzy_malejaco(Min, Max, Liczba) :-
    (
        Min == Max,

        Liczba = Max
    );
    (
        Min =\= Max,

        (
            Liczba = Max;
            (
                Nowy_Max is Max - 1,
                liczby_pomiedzy_malejaco(Min, Nowy_Max, Liczba)
            )
        )
    ).


% Zwraca dlugosc listy Lista jako Dlugosc
dlugosc([], 0).
dlugosc(Lista, Dlugosc) :-
    [A | Ogon] = Lista,
    dlugosc(Ogon, Dlugosc_minus1),
    Dlugosc is Dlugosc_minus1 + 1.


% Predykat pomocniczy predykatu najw. Przeszukuje listę w celu
% znalezienia najwiekszego elementu.
najw_petla([], Kandydat, Wywolano_Rekurencyjnie, Kandydat).
najw_petla(Lista, Kandydat, Wywolano_Rekurencyjnie, Nowy_Kandydat) :-
    [A | Ogon] = Lista,
    (
        (
            \+ Wywolano_Rekurencyjnie,
            Nowy_Kandydat_Tymczasowy = A
        );
        (
            Wywolano_Rekurencyjnie,
            A > Kandydat,
            Nowy_Kandydat_Tymczasowy = A
        );
        (
            Nowy_Kandydat_Tymczasowy = Kandydat
        )
    ),
    najw_petla(Ogon, Nowy_Kandydat_Tymczasowy, true, Nowy_Kandydat).


% Zwraca jako Najw element najwiekszy z listy Lista.
najw(Lista, Najw) :-
    najw_petla(Lista, 0, false, Najw).


% Predykat pomocniczy predykatu najb_wysun_prawo. Przechodzi po planszy
% Plansza w lewo, szukajac pierwszego elementu wiekszego od 0. Zwraca
% wynik jako Najb_Wysun_Prawo
najb_wysun_prawo_petla(Plansza, -1, 0).
najb_wysun_prawo_petla(Plansza, Sprawdzana_Pozycja, Najb_Wysun_Prawo) :-
    ity(Plansza, Sprawdzana_Pozycja, Na_Sprawdzanej_Pozycji),
    (
        Na_Sprawdzanej_Pozycji > 0,
        Najb_Wysun_Prawo = Na_Sprawdzanej_Pozycji
    );
    (
        Nowa_Sprawdzana_Pozycja is Sprawdzana_Pozycja - 1,
        najb_wysun_prawo_petla(Plansza, Nowa_Sprawdzana_Pozycja, Najb_Wysun_Prawo)
    ).


% Zwraca jako Najb_Wysun_Prawo liczbe pionkow znajdujacych
% sie na najbardziej wysunietym na prawo polu planszy Plansza
najb_wysun_prawo(Plansza, Najb_Wysun_Prawo) :-
    dlugosc(Plansza, Dlugosc),
    Sprawdzana_Pozycja is Dlugosc - 1,

    najb_wysun_prawo_petla(Plansza, Sprawdzana_Pozycja, Najb_Wysun_Prawo).


% Dolacza Element na poczatek listy Lista.
% Zwraca wynik jako Nowa_Lista
dolacz_na_poczatek(Element, Lista, Nowa_Lista) :-
    Nowa_Lista = [Element | Lista].


% Wstawia Element na pozycje Pozycja w liscie Lista.
% Zwraca wynik jako Nowa_Lista
wstaw_na_pozycje(Element, [A | Ogon], 0, [Element | Ogon]).
wstaw_na_pozycje(Element, Lista, Pozycja, Nowa_Lista) :-
    [A | Ogon] = Lista,
    Nowa_Pozycja is Pozycja - 1,

    wstaw_na_pozycje(Element, Ogon, Nowa_Pozycja, Nowy_Ogon),
    dolacz_na_poczatek(A, Nowy_Ogon, Nowa_Lista).


% Inkrementuje element na pozycji Pozycja w liscie Lista.
% Zwraca wynik jako Nowa_Lista
inkr(Lista, Pozycja, Nowa_Lista) :-
    ity(Lista, Pozycja, Na_Pozycji),
    Nowy_Na_Pozycji is Na_Pozycji + 1,
    wstaw_na_pozycje(Nowy_Na_Pozycji, Lista, Pozycja, Nowa_Lista).


% Dekrementuje element na pozycji Pozycja w liscie Lista.
% Zwraca wynik jako Nowa_Lista
dekr(Lista, Pozycja, Nowa_Lista) :-
    ity(Lista, Pozycja, Na_Pozycji),
    Nowy_Na_Pozycji is Na_Pozycji - 1,
    wstaw_na_pozycje(Nowy_Na_Pozycji, Lista, Pozycja, Nowa_Lista).


% Zwraca jako Nowy_Gracz gracza wykonujacego ruch po graczu Gracz
nowy_gracz(Gracz, Nowy_Gracz) :-
    (
        Gracz == 1,
        Nowy_Gracz = 2
    );
    (
        Gracz == 2,
        Nowy_Gracz = 1
    ).


% Predykat pomocniczy predykatu pozycja_cel. Przesuwajac sie po planszy, szuka najdalszego 
% miejsca, na ktore moze nastapic przesuniecie pionka przy uwzglednieniu przeskakiwania
pozycja_najdalszy_cel_z_przeskakiwaniem(Plansza, Pozycja_Zrodlo, Przesuniecie, Znak_Przesuniecia, Pozycja_Najdalszy_Cel) :-
    (
        Przesuniecie == 0,

        Pozycja_Najdalszy_Cel = Pozycja_Zrodlo
    );
    (
        Przesuniecie =\= 0,

        Sprawdzana_Pozycja is Pozycja_Zrodlo + Znak_Przesuniecia,
        dlugosc(Plansza, Dlugosc),
        (
            (   
                Sprawdzana_Pozycja >= 0,
                Sprawdzana_Pozycja < Dlugosc,
                % Sprawdzana_Pozycja istnieje

                ity(Plansza, Sprawdzana_Pozycja, Na_Sprawdzanej_Pozycji),
                (
                    (
                        Na_Sprawdzanej_Pozycji == 0,

                        Nowe_Przesuniecie is Przesuniecie - 1
                    );
                    (
                        Na_Sprawdzanej_Pozycji > 0,

                        Nowe_Przesuniecie = Przesuniecie
                    )
                ),
                Nowa_Pozycja_Zrodlo = Sprawdzana_Pozycja,
                pozycja_najdalszy_cel_z_przeskakiwaniem(Plansza, Nowa_Pozycja_Zrodlo, Nowe_Przesuniecie, Znak_Przesuniecia, Pozycja_Najdalszy_Cel)
            );
            (
                (
                    Sprawdzana_Pozycja < 0;
                    Sprawdzana_Pozycja >= Dlugosc
                ),
                % Sprawdzana_Pozycja nie istnieje

                Pozycja_Najdalszy_Cel = Pozycja_Zrodlo
            )
        )
    ).


% Zwraca pozycje, na ktora ma nastapic przesuniecie pionka z pozycji Pozycja_Zrodlo
pozycja_cel(Plansza, Pozycja_Zrodlo, Przesuniecie, Kierunek, Przeskakiwanie_Dozwolone, Pozycja_Cel) :-
    (
        (
            Kierunek == prawo,
            Znak_Przesuniecia is 1
        );
        (
            Kierunek == lewo,
            Znak_Przesuniecia is -1
        )
    ),
    (
        (
            \+ Przeskakiwanie_Dozwolone,

            Pozycja_Cel is Pozycja_Zrodlo + (Znak_Przesuniecia * Przesuniecie)
        );
        (
            Przeskakiwanie_Dozwolone,

            Pozycja_Najblizszy_Cel is Pozycja_Zrodlo + (Znak_Przesuniecia * Przesuniecie),
            pozycja_najdalszy_cel_z_przeskakiwaniem(Plansza, Pozycja_Zrodlo, Przesuniecie, Znak_Przesuniecia, Pozycja_Najdalszy_Cel),
            (
                (
                    Kierunek == prawo,
                    Pozycja_Najblizszy_Cel =< Pozycja_Najdalszy_Cel,

                    liczby_pomiedzy_rosnaco(Pozycja_Najblizszy_Cel, Pozycja_Najdalszy_Cel, Pozycja_Cel)
                );
                (
                    Kierunek == lewo,
                    Pozycja_Najdalszy_Cel =< Pozycja_Najblizszy_Cel,

                    liczby_pomiedzy_malejaco(Pozycja_Najdalszy_Cel, Pozycja_Najblizszy_Cel, Pozycja_Cel)
                )
            )
        )
    ).
  

% Predykat pomocniczy predykatu przesun. Przesuwa pionek z pozycji Pozycja_Zrodlo,
% po czym przechodzi do kolejnego pionka
przesun_petla(Plansza, Pozycja_Zrodlo, Przesuniecie, Kierunek, Przeskakiwanie_Dozwolone, Nowa_Plansza) :-
    (
        ity(Plansza, Pozycja_Zrodlo, Liczba_Pionkow_Zrodlo),
        Liczba_Pionkow_Zrodlo > 0,

        pozycja_cel(Plansza, Pozycja_Zrodlo, Przesuniecie, Kierunek, Przeskakiwanie_Dozwolone, Pozycja_Cel),
        ity(Plansza, Pozycja_Cel, Liczba_Pionkow_Cel),
        
        dekr(Plansza, Pozycja_Zrodlo, Plansza_Po_Zabraniu_Ze_Zrodla),
        inkr(Plansza_Po_Zabraniu_Ze_Zrodla, Pozycja_Cel, Nowa_Plansza)
    );
    (
        dlugosc(Plansza, Dlugosc),
        Pozycja_Zrodlo < Dlugosc,

        Nowa_Pozycja_Zrodlo is Pozycja_Zrodlo + 1,
        przesun_petla(Plansza, Nowa_Pozycja_Zrodlo, Przesuniecie, Kierunek, Przeskakiwanie_Dozwolone, Nowa_Plansza)
    ).


% Generuje wszystkie przesuniecia o Przesuniecie w kierunku Kierunek (atom prawo albo lewo)
% pionka na planszy Plansza. Zwraca wyniki jako Nowa_Plansza
przesun(Plansza, Przesuniecie, Kierunek, Przeskakiwanie_Dozwolone, Nowa_Plansza) :-
    przesun_petla(Plansza, 0, Przesuniecie, Kierunek, Przeskakiwanie_Dozwolone, Nowa_Plansza).


% Sprawdza, czy stan planszy Plansza jest zgodny z ta czescia zasady Zasada,
% ktora obowiazuje w momencie Moment (atom podczas_ruchu albo po_ruchu)
zgodny_z_zasada(Plansza, Zasada, Moment) :-
    najw(Plansza, Najw),
    najb_wysun_prawo(Plansza, Najb_Wysun_Prawo),
    !,
    (
        (
            Zasada == 0,
           

            Najw =< 2
        );
        (
            Zasada == 3,
            % moment nie ma znaczenia, gdyz ruch sklada sie z jednego poruszenia,
            % a wiec natychmiast sie konczy

            Najw =< 2,
            Najb_Wysun_Prawo =< 2
        );
        (
            Zasada == 9,

            (
                (
                    Moment == podczas_ruchu,
                    
                    Najw =< 2
                );
                (
                    Moment == po_ruchu,

                    Najw =< 1,
                    Najb_Wysun_Prawo =< 1
                )
            )
        )
    ).


% Zwraca jako Nowa_Plansza stan planszy Plansza zmieniony przez ruch gracza Gracz 
nowy_stan(Plansza, Gracz, Nowa_Plansza) :-
    (
        Gracz == 1,
        % gra wg zasady 9

        (
            (
                % wybor przesuniecia 1 pionka w prawo o 1
                przesun(Plansza, 1, prawo, true, Nowa_Plansza),
                zgodny_z_zasada(Nowa_Plansza, 9, po_ruchu)
            );
            (
                % wybor przesuniecia 1 pionka w lewo o 1, a nastepnie
                % 1 pionka w prawo o 2
                przesun(Plansza, 1, lewo, true, Plansza_Przejsciowa),
                zgodny_z_zasada(Plansza_Przejsciowa, 9, podczas_ruchu),

                przesun(Plansza_Przejsciowa, 2, prawo, true, Nowa_Plansza),
                zgodny_z_zasada(Nowa_Plansza, 9, po_ruchu)
            );
            (
                % wybor przesuniecia 1 pionka w prawo o 2, a nastepnie
                % 1 pionka w lewo o 1
                przesun(Plansza, 2, prawo, true, Plansza_Przejsciowa),
                zgodny_z_zasada(Plansza_Przejsciowa, 9, podczas_ruchu),

                przesun(Plansza_Przejsciowa, 1, lewo, true, Nowa_Plansza),
                zgodny_z_zasada(Nowa_Plansza, 9, po_ruchu)
            )
        )
    );
    (
        Gracz == 2,
        % gra wg zasady 3

        (
            przesun(Plansza, 1, prawo, false, Nowa_Plansza);
            przesun(Plansza, 3, prawo, false, Nowa_Plansza)
        ),
        zgodny_z_zasada(Nowa_Plansza, 3, po_ruchu)
    ).


generuj_poddrzewo_gry(Plansza, Aktywny_Gracz, Zaglebienie) :-
    (
        nowy_stan(Plansza, Aktywny_Gracz, Nowa_Plansza),
        % Otrzymano nowy mozliwy stan

        Nowe_Zaglebienie is Zaglebienie + 1,

        write(Nowe_Zaglebienie),
        write(':'),
        write(Nowa_Plansza),
        write(' '),

        nowy_gracz(Aktywny_Gracz, Nowy_Aktywny_Gracz),

        generuj_poddrzewo_gry(Nowa_Plansza, Nowy_Aktywny_Gracz, Nowe_Zaglebienie)
    );
    (
        var(Nowa_Plansza),
        % Nie ma juz wiecej mozliwych stanow

        nl
    ).


czy_wygrywa(Plansza) :-
    generuj_poddrzewo_gry(Plansza, 1, 0).