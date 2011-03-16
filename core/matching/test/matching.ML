local
open MkG;
structure MatchSearch = SimpleMatchSearch;
val no_extra_names = (V.NSet.empty, E.NSet.empty, G.BBox.NSet.empty);
fun match g1 g2 = Seq.list_of (MatchSearch.match no_extra_names g1 g2 RGVertex.NTab.empty);
in val _ = let 

(* Graph: (B - G) *)
val g = G.empty;
val (b1, g) = g |> G.add_vertex bvert;
val (n1, g) = g |> G.add_vertex (mkX zero_angle);
val (e0, g) = g |> G.add_edge undir_edge b1 n1;
val g0 = g;

(* Graph: (B - G - B) *)
val g = G.empty;
val (b1, g) = g |> G.add_vertex bvert;
val (n1, g) = g |> G.add_vertex (mkX zero_angle);
val (b2, g) = g |> G.add_vertex bvert;
val (e0, g) = g |> G.add_edge undir_edge b1 n1;
val (e1, g) = g |> G.add_edge undir_edge n1 b2;
val g1 = g;

val ms = match g1 g0;
val _ = map Match.print ms;
val [] = ms;

val (_,g2) = G.rename_apart g1 g;
val _ = G.print g1;
val _ = V.NSet.print (G.get_leaf_vnames g1);
val _ = G.print g2;

val ms = match g1 g2;
val _ = map Match.print ms;
val [m1,m2] = ms;

val g = G.empty;
val (b1, g) = g |> G.add_vertex bvert;
val (b2, g) = g |> G.add_vertex bvert;
val (n1, g) = g |> G.add_vertex (mkX zero_angle);
val (n2, g) = g |> G.add_vertex (mkZ zero_angle);
val (_, g) = g |> G.add_edge undir_edge n2 n1;
val (_, g) = g |> G.add_edge undir_edge b1 n2;
val (_, g) = g |> G.add_edge undir_edge b2 n2;
val pat1 = g;

val g = G.empty;
val (b1, g) = g |> G.add_vertex bvert;
val (b2, g) = g |> G.add_vertex bvert;
val (n1, g) = g |> G.add_vertex (mkX pi_angle);
val (n2, g) = g |> G.add_vertex (mkZ zero_angle);
val (_, g) = g |> G.add_edge undir_edge n2 n1;
val (_, g) = g |> G.add_edge undir_edge b1 n2;
val (_, g) = g |> G.add_edge undir_edge b2 n2;
val pat2 = g;

val g = G.empty;
val (b1, g) = g |> G.add_vertex bvert;
val (b2, g) = g |> G.add_vertex bvert;
val (n1, g) = g |> G.add_vertex (mkX (var_angle "a"));
val (n2, g) = g |> G.add_vertex (mkZ zero_angle);
val (_, g) = g |> G.add_edge undir_edge n2 n1;
val (_, g) = g |> G.add_edge undir_edge b1 n2;
val (_, g) = g |> G.add_edge undir_edge b2 n2;
val tgt = g;

val pat = pat1;
val (rn,pat) = (G.rename_apart tgt pat);
val [] = match pat1 tgt;
val [] = match pat2 tgt;

val g = G.empty;
val (b1, g) = g |> G.add_vertex bvert;
val (_, g) = g |> G.add_edge undir_edge b1 b1;
val pat = g;

val g = G.empty;
val (n1, g) = g |> G.add_vertex (mkX zero_angle);
val (_, g) = g |> G.add_edge undir_edge n1 n1;
val (_, g) = g |> G.add_edge undir_edge n1 n1;
val tgt = g;

val (rn,pat) = (G.rename_apart tgt pat);
val _ = G.print pat;
val _ = G.print tgt;

val [m] = match pat tgt;
val _ = Match.print m;


(* X spider self-loop lhs deletion *)
val g = G.empty;
val (b1, g) = g |> G.add_vertex bvert;
val (n1, g) = g |> G.add_vertex (mkX (var_angle "a"));
val (_, g) = g |> G.add_edge undir_edge n1 n1;
val (_, g) = g |> G.add_edge undir_edge b1 n1;
val (bbn, g) = g |> G.new_box (G.BBox.mk "B0");
val g = g |> G.move_to_box bbn (V.NSet.single b1);
val pat = g;

(* single self-loop on X(0) *)
val g = G.empty;
val (n1, g) = g |> G.add_vertex (mkX (var_angle "0"));
val (_, g) = g |> G.add_edge undir_edge n1 n1;
val tgt = g;

val (rn,pat) = (G.rename_apart tgt pat);
val _ = G.print pat;
val _ = G.print tgt;

val [m] = match pat tgt RGVertex.NTab.empty);
val _ = Match.print m;

(* one unfolding of bangbox...*)
val g = G.empty;
val (b1, g) = g |> G.add_vertex bvert;
val (n1, g) = g |> G.add_vertex (mkX (var_angle "b"));
val (_, g) = g |> G.add_edge undir_edge n1 n1;
val (_, g) = g |> G.add_edge undir_edge b1 n1;
val tgt = g;

val (rn,pat) = (G.rename_apart tgt pat);
val _ = G.print pat;
val _ = G.print tgt;

val [m] = match pat tgt;
val _ = Match.print m;



(* one unfolding of bangbox...*)
(* 
val g = G.empty;
val (b1, g) = g |> G.add_vertex bvert;
val (b2, g) = g |> G.add_vertex bvert;
val (n1, g) = g |> G.add_vertex (mkX (var_angle "b"));
val (_, g) = g |> G.add_edge undir_edge n1 n1;
val (_, g) = g |> G.add_edge undir_edge b1 n1;
val (_, g) = g |> G.add_edge undir_edge b2 n1;
val tgt = g;

val (rn,pat) = (G.rename_apart tgt pat);
val _ = G.print pat;
val _ = G.print tgt;

val [m] = Seq.list_of (MatchSearch.match pat tgt RGVertex.NTab.empty);
val _ = Match.print m;
*)
in
 Pretty.writeln (Pretty.str "Tests passed: graph matching.")
end  (* let *)
handle e => 
       (Pretty.writeln (Pretty.str "Test Failed: graph matching."); raise e);
end; (* local *)
