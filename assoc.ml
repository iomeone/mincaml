(* flatten let-bindings (just for prettier printing) *)

open KNormal

let rec f = function (* �ͥ��Ȥ���let�δ��� (caml2html: assoc_f) *)
  | IfEq(x, y, e1, e2) -> IfEq(x, y, f e1, f e2)
  | IfLE(x, y, e1, e2) -> IfLE(x, y, f e1, f e2)
  | Let(xt, e1, e2) -> (* let�ξ�� (caml2html: assoc_let) *)
      let rec insert = function
	| Let(yt, e3, e4) -> Let(yt, e3, insert e4)
	| LetRec(fundefs, e) -> LetRec(fundefs, insert e)
	| e -> Let(xt, e, f e2) in
      insert (f e1)
  | LetRec(fundefs, e2) ->
      LetRec(List.map
	       (fun { name = xt; args = yts; body = e1 } ->
		 { name = xt; args = yts; body = f e1 })
	       fundefs,
	     f e2)
  | LetTuple(xts, y, e) -> LetTuple(xts, y, f e)
  | e -> e
