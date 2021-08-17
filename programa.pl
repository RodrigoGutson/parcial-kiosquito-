% Base de conocimientos 

atiende(dodain, lunes, Hora):-
    between(9, 15, Hora).
atiende(dodain, miercoles, Hora):-
    between(9, 15, Hora).
atiende(dodain, viernes, Hora):-
    between(9, 15, Hora).
atiende(lucas, martes, Hora):-
    between(10, 20, Hora).
atiende(juanC, sabado, Hora):-
    between(18, 22, Hora).
atiende(juanC, domingo, Hora):-
    between(18, 22, Hora).
atiende(juanFdS, jueves, Hora):-
    between(10, 20, Hora).
atiende(juanFdS, viernes, Hora):-
    between(12, 20, Hora).
atiende(leoC, lunes, Hora):-
    between(14, 18, Hora).
atiende(leoC, miercoles, Hora):-
    between(14, 18, Hora).
atiende(martu, miercoles, Hora):-
    between(23, 24, Hora).
    
%%% PUNTO 1 %%%%

atiende(vale, Dia, Hora):-
    atiende(dodain, Dia, Hora).
atiende(vale, Dia, Hora):-
    atiende(juanC, Dia, Hora).

/*Por principo de universo cerrado (es falso todo lo que no se pueda probar), no hace falta incluir que nadie atiende en el mismo horario que leoC 
ya que todo lo que no este dentro de la base de conocimiento se considera falso */

%%% PUNTO 2 %%% 

atiendeTalDiaYHora(Persona, Dia, Hora):-
    atiende(Persona, Dia, Hora).

%%% PUNTO 3 %%% 

foreverAlone(Persona, Dia, Hora):-
    atiendeTalDiaYHora(Persona, Dia, Hora),
    not(atiendeMasDeUno(Dia, Hora)).

atiendeMasDeUno(Dia, Hora):-
    atiendeTalDiaYHora(Persona, Dia, Hora),
    atiendeTalDiaYHora(OtraPersona, Dia, Hora),
    Persona \= OtraPersona.
    
%%% PUNTO 4 %%%

podriaEstarAtendiendo(Dia, Posibilidades):-
    findall(Persona, atiendeTalDiaYHora(Persona, Dia, _), PersonasQueTrabajanEseDiaRepes),
    list_to_set(PersonasQueTrabajanEseDiaRepes, PersonasQueTrabajanEseDia),
    estaIncluidoEn(PersonasQueTrabajanEseDia, Posibilidades).

% estaIncluidoEn(Conjunto, Subconjunto)

estaIncluidoEn([X|Lista], [X|OtraLista]):-
    estaIncluidoEn(Lista, OtraLista).
estaIncluidoEn([_|Lista], OtraLista):-
    estaIncluidoEn(Lista, OtraLista).
estaIncluidoEn([], []). 

%%% PUNTO 5 %%%

vendio(dodain, fecha(lunes, 10, agosto), [golosinas(1200), cigarrillos([jockey]), golosinas(50)]).
vendio(dodain, fecha(miercoles, 12, agosto), [bebida(conAlcohol, 8), bebida(sinAlcohol, 1), golosinas(10)]).
vendio(martu, fecha(miercoles, 12, agosto), [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).
vendio(lucas, fecha(martes, 11, agosto), [golosinas(600)]).
vendio(lucas, fecha(martes, 18, agosto), [bebida(sinAlcohol, 2), cigarrillos([derby])]).

personaVendio(Persona):- vendio(Persona, _, _).

esSuertuda(Persona):-
    personaVendio(Persona),
    forall(vendio(Persona, Fecha, _), primeraVentaImportante(Persona, Fecha)).

primeraVentaImportante(Persona, Fecha):-
    primerVenta(Persona, Fecha, PrimerVenta),
    cumpleCondicionImportante(PrimerVenta).

primerVenta(Persona, Fecha, PrimerVenta):-
    vendio(Persona, Fecha, [PrimerVenta|_]).

cumpleCondicionImportante(golosinas(Monto)):-
    Monto > 100.
cumpleCondicionImportante(cigarrillos(Marcas)):-
    length(Marcas, CantMarcas),
    CantMarcas > 2.
cumpleCondicionImportante(bebida(conAlcohol, _)).
cumpleCondicionImportante(bebida(_, Cantidad)):-
    Cantidad > 5.
    
    
    

    
