% Bruno Maglioni A01700879

% Notes (12-tone chromatic scale)
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
