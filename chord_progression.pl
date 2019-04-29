% Bruno Maglioni A01700879

% === Knowledge Base === %

% ------- Notes ------- %
% 12-tone chromatic scale
is_note(c).
is_note(c_sharp). is_note(d_flat).
is_note(d).
is_note(d_sharp). is_note(e_flat).
is_note(e).
is_note(f).
is_note(f_sharp). is_note(g_flat).
is_note(g).
is_note(g_sharp). is_note(a_flat).
is_note(a).
is_note(a_sharp). is_note(b_flat).
is_note(b).

% Notes that are equal
same_note(c_sharp, d_flat).
same_note(d_sharp, e_flat).
same_note(f_sharp, g_flat).
same_note(g_sharp, a_flat).
same_note(a_sharp, b_flat).


% ------- Scale ------- %
% Standard note progression (using sharps)
next(c, c_sharp).
next(c_sharp, d).
next(d, d_sharp).
next(d_sharp, e).
next(e, f).
next(f, f_sharp).
next(f_sharp, g).
next(g, g_sharp).
next(g_sharp, a).
next(a, a_sharp).
next(a_sharp, b).
next(b, c).

% Reverse note progression (using flats)
prev(c, b).
prev(b, b_flat).
prev(b_flat, a).
prev(a, a_flat).
prev(a_flat, g).
prev(g, g_flat).
prev(g_flat, f).
prev(f, e).
prev(e, e_flat).
prev(e_flat, d).
prev(d, d_flat).
prev(d_flat, c).


% ------- Chord progressions ------- %
% progression_type(Number_of_chord, Semitones_to_next_note, Quality)

% Major -> I ii iii IV V vi vii°
major(1, 2, maj).
major(2, 2, min).
major(3, 1, min).
major(4, 2, maj).
major(5, 2, maj).
major(6, 2, min).
major(7, 1, dim).

% Minor -> i ii° III iv v VI VII
minor(1, 2, min).
minor(2, 1, dim).
minor(3, 2, maj).
minor(4, 2, min).
minor(5, 1, min).
minor(6, 2, maj).
minor(7, 2, maj).

% === Rules === %

% ------- Intervals ------- %
% next_n_semitone(Root, Number, Note)
% Binds to Note the nth semitone starting from Root.
% next_n_semitone(g, 5, R) -> R = c
next_n_semitone(Root, 0, Root):-!.

next_n_semitone(Root, Number, Note):-
  is_note(Root),
  NewNumber is Number - 1,
  next(Root, NewRoot),
  next_n_semitone(NewRoot, NewNumber, Note).

% Main intervals (chromatic scale)
perfect_unison(Root, Note):-
  next_n_semitone(Root, 0, Note).

minor_second(Root, Note):-
  next_n_semitone(Root, 1, Note).

major_second(Root, Note):-
  next_n_semitone(Root, 2, Note).

minor_third(Root, Note):-
  next_n_semitone(Root, 3, Note).

major_third(Root, Note):-
  next_n_semitone(Root, 4, Note).

perfect_fourth(Root, Note):-
  next_n_semitone(Root, 5, Note).

tritone(Root, Note):-
  next_n_semitone(Root, 6, Note).

perfect_fifth(Root, Note):-
  next_n_semitone(Root, 7, Note).

minor_sixth(Root, Note):-
  next_n_semitone(Root, 8, Note).

major_sixth(Root, Note):-
  next_n_semitone(Root, 9, Note).

minor_seventh(Root, Note):-
  next_n_semitone(Root, 10, Note).

major_seventh(Root, Note):-
  next_n_semitone(Root, 11, Note).

perfect_octave(Root, Note):-
  next_n_semitone(Root, 12, Note).


% ------- Chords ------- %
% Chord building

% Triads
% Returns a list with the major chord built from the Root
major_chord(Root, [N1, N2, N3]):-
  is_note(Root),
  upcase_atom(Root, N1),
  major_third(Root, Note2),
  upcase_atom(Note2, N2),
  perfect_fifth(Root, Note3),
  upcase_atom(Note3, N3).

% Returns a list with the minor chord built from the Root
minor_chord(Root, [N1, N2, N3]):-
  is_note(Root),
  upcase_atom(Root, N1),
  minor_third(Root, Note2),
  upcase_atom(Note2, N2),
  perfect_fifth(Root, Note3),
  upcase_atom(Note3, N3).

% Returns a list with the diminished chord built from the Root
diminished_chord(Root, [N1, N2, N3]):-
  is_note(Root),
  upcase_atom(Root, N1),
  minor_third(Root, Note2),
  upcase_atom(Note2, N2),
  tritone(Root, Note3),
  upcase_atom(Note3, N3).

% Returns a list with the augmented chord built from the Root
augmented_chord(Root, [N1, N2, N3]):-
  is_note(Root),
  upcase_atom(Root, N1),
  major_third(Root, Note2),
  upcase_atom(Note2, N2),
  minor_sixth(Root, Note3),
  upcase_atom(Note3, N3).

sus2_chord(Root, [N1, N2, N3]):-
  is_note(Root),
  upcase_atom(Root, N1),
  major_second(Root, Note2),
  upcase_atom(Note2, N2),
  perfect_fifth(Root, Note3),
  upcase_atom(Note3, N3).

sus4_chord(Root, [N1, N2, N3]):-
  is_note(Root),
  upcase_atom(Root, N1),
  perfect_fourth(Root, Note2),
  upcase_atom(Note2, N2),
  perfect_fifth(Root, Note3),
  upcase_atom(Note3, N3).

% Tetrads
major_seventh_chord(Root, [N1, N2, N3, N4]):-
  is_note(Root),
  upcase_atom(Root, N1),
  major_third(Root, Note2),
  upcase_atom(Note2, N2),
  perfect_fifth(Root, Note3),
  upcase_atom(Note3, N3),
  major_seventh(Root, Note4),
  upcase_atom(Note4, N4).

minor_seventh_chord(Root, [N1, N2, N3, N4]):-
  is_note(Root),
  upcase_atom(Root, N1),
  minor_third(Root, Note2),
  upcase_atom(Note2, N2),
  perfect_fifth(Root, Note3),
  upcase_atom(Note3, N3),
  minor_seventh(Root, Note4),
  upcase_atom(Note4, N4).

dominant_seventh_chord(Root, [N1, N2, N3, N4]):-
  is_note(Root),
  upcase_atom(Root, N1),
  major_third(Root, Note2),
  upcase_atom(Note2, N2),
  perfect_fifth(Root, Note3),
  upcase_atom(Note3, N3),
  minor_seventh(Root, Note4),
  upcase_atom(Note4, N4).

% Chord naming

% Binds to Chord the name based on quaility (Major, Minor, Dim)
% name_chord(d, min, X). -> X = 'Dm'
name_chord(Key, Quality, Chord):-
  % Major chord
  is_note(Key),
  Quality == maj,
  upcase_atom(Key, Chord), !;
  % Minor chord
  is_note(Key),
  Quality == min,
  upcase_atom(Key, Ch),
  atom_concat(Ch, 'm', Chord), !;
  % Diminished chord
  is_note(Key),
  Quality == dim,
  upcase_atom(Key, Ch),
  atom_concat(Ch, 'dim', Chord), !.

% ------- Chord Progression ------- %
% Builds the chord progression in the Key and Quality given
% build_progression(c, major, X). -> X = ['C', 'Dm', 'Em', 'F', 'G', 'Am', 'Bdim']
build_progression(Key, Quality, List):-
  is_note(Key),
  Quality == major,
  build(Key, major, 1, List), !;
  Quality == minor,
  build(Key, minor, 1, List).

% Base case
build(_, _, 8, []):- !.

% Major progression
build(Key, major, N, [H|T]):-
  N < 8,
  major(N, ST, Quality),
  name_chord(Key, Quality, H),
  % print(H),
  next_n_semitone(Key, ST, NewKey),
  NewN is N + 1,
  build(NewKey, major, NewN, T).

% Minor progression
build(Key, minor, N, [H|T]):-
  N < 8,
  minor(N, ST, Quality),
  name_chord(Key, Quality, H),
  % print(H),
  next_n_semitone(Key, ST, NewKey),
  NewN is N + 1,
  build(NewKey, minor, NewN, T).


% ------- Modes ------- %
% Characteristic chord combination for relative modes

dorian(Tonic, [Chord1, Chord2]):-
  name_chord(Tonic, min, Chord1),
  perfect_fourth(Tonic, Note),
  name_chord(Note, maj, Chord2).

phrygian(Tonic, [Chord1, Chord2]):-
  name_chord(Tonic, min, Chord1),
  minor_second(Tonic, Note),
  name_chord(Note, maj, Chord2).

lydian(Tonic, [Chord1, Chord2]):-
  name_chord(Tonic, maj, Chord1),
  major_second(Tonic, Note),
  name_chord(Note, maj, Chord2).

mixolydian(Tonic, [Chord1, Chord2]):-
  name_chord(Tonic, maj, Chord1),
  minor_seventh(Tonic, Note),
  name_chord(Note, maj, Chord2).
