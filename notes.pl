% Bruno Maglioni A01700879

% Notes
is_note(c).
is_note(d).
is_note(e).
is_note(f).
is_note(g).
is_note(a).
is_note(b).

% Standard note progression
next(c, d).
next(d, e).
next(e, f).
next(f, g).
next(g, a).
next(a, b).
next(b, c).

% Reverse note progression
prev(c, b).
prev(b, a).
prev(a, g).
prev(g, f).
prev(f, e).
prev(e, d).
prev(d, c).

% next_n_note(BaseNote, Number, Res)
% Binds to Res the nth note starting from BaseNote.
% next_n_note(g, 5, R) -> R = d
next_n_note(BaseNote, 1, BaseNote):-!.

next_n_note(BaseNote, Number, Res):-
  is_note(BaseNote),
  NewNumber is Number - 1,
  next(BaseNote, NewBaseNote),
  next_n_note(NewBaseNote, NewNumber, Res).
