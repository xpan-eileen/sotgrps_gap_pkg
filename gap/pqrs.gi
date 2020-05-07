msg.allGroupsPQRS := function(n)
  local all, fac, p, q, r, s, u, v, w, case1, case2, case3, case4, case5, case6, case7, case8;
    all := [];
    fac := Factors(n);
    if not Length(fac) = 4 or not Length(Collected(fac)) = 4 then
      Error("Argument must be of the form of pqrs");
    else
      p := fac[1];
      q := fac[2];
      r := fac[3];
      s := fac[4];
    fi;
    Add(all, msg.groupFromData([ [p, q, r, s] ]));
    u := Z(q);
    v := Z(r);
    w := Z(s);
    ### case 1: |F| = s, pqr | (s - 1), and G \cong C_{pqr} \ltimes C_s
    case1 := function(p, q, r, s)
      local data;
        data := [ [p, q, r, s], [4, 1, [4, Int(w^((s - 1)/p))]], [4, 2, [4, Int(w^((s - 1)/q))]], [4, 3, [4, Int(w^((s - 1)/r))]] ];
      return msg.groupFromData(data);
    end;

    if (s - 1) mod (p*q*r) = 0 then
      Add(all, case1(p, q, r, s));
    fi;

    ### case 2: |F| = rs, pq | (r - 1)(s - 1), and G \cong C_{pq} \ltimes C_{rs}
    case2 := function(p, q, r, s)
      local list, data1, data2, data3_kl, data4_k, data5_k, data6_k, data7_k, data8, data9, i, j;
        list := [];
        data1 := function(p, q, r, s)
          local data;
            data := [ [p, q, r, s], [3, 1, [3, Int(v^((r - 1)/p))]], [3, 2, [3, Int(v^((r - 1)/q))]] ];
          return msg.groupFromData(data);
        end;

        if (r - 1) mod (p*q) = 0 then
          Add(list, data1(p, q, r, s));
        fi;

        data2 := function(p, q, r, s)
          local data;
            data := [ [p, q, r, s], [4, 1, [4, Int(w^((s - 1)/p))]], [4, 2, [4, Int(w^((s - 1)/q))]] ];
          return msg.groupFromData(data);
        end;

        if (s - 1) mod (p*q) = 0 then
          Add(list, data2(p, q, r, s));
        fi;

        data3_kl := function(k, l)
          local data;
            data := [ [p, q, r, s], [3, 1, [3, Int(v^((r - 1)/p))]], [3, 2, [3, Int(v^((r - 1)/q))]], [4, 1, [4, Int(w^(k*(s - 1)/p))]], [4, 2, [4, Int(w^(l*(s - 1)/q))]] ];
          return msg.groupFromData(data);
        end;

        data4_k := function(k)
          local data;
            data := [ [p, q, r, s], [3, 1, [3, Int(v^(k*(r - 1)/p))]], [4, 1, [4, Int(w^((s - 1)/p))]], [4, 2, [4, Int(w^((s - 1)/q))]] ];
          return msg.groupFromData(data);
        end;

        data5_k := function(l)
          local data;
            data := [ [p, q, r, s], [3, 2, [3, Int(v^(l*(r - 1)/q))]], [4, 1, [4, Int(w^((s - 1)/p))]], [4, 2, [4, Int(w^((s - 1)/q))]] ];
          return msg.groupFromData(data);
        end;

        data6_k := function(k)
          local data;
            data := [ [p, q, r, s], [3, 1, [3, Int(v^((r - 1)/p))]], [3, 2, [3, Int(v^((r - 1)/q))]], [4, 1, [4, Int(w^(k*(s - 1)/p))]] ];
          return msg.groupFromData(data);
        end;

        data7_k := function(l)
          local data;
            data := [ [p, q, r, s], [3, 1, [3, Int(v^((r - 1)/p))]], [3, 2, [3, Int(v^((r - 1)/q))]], [4, 2, [4, Int(w^(l*(s - 1)/q))]] ];
          return msg.groupFromData(data);
        end;


        if (s - 1) mod (p*q) = 0 and (r - 1) mod (p*q) = 0 then
          for i in [1..(p - 1)] do
            for j in [1..(q - 1)] do
              Add(list, data3_kl(i, j));
            od;
          od;
        fi;

        if (r - 1) mod p = 0 and (s - 1) mod (p*q) = 0 then
          for i in [1..(p - 1)] do
            Add(list, data4_k(i));
          od;
        fi;

        if (r - 1) mod q = 0 and (s - 1) mod (p*q) = 0 then
          for j in [1..(q - 1)] do
            Add(list, data5_k(j));
          od;
        fi;

        if (s - 1) mod p = 0 and (r - 1) mod (p*q) = 0 then
          for i in [1..(p - 1)] do
            Add(list, data6_k(i));
          od;
        fi;

        if (s - 1) mod q = 0 and (r - 1) mod (p*q) = 0 then
          for j in [1..(q - 1)] do
            Add(list, data7_k(j));
          od;
        fi;

        data8 := function(p, q, r, s)
          local data;
            data := [ [p, q, r, s], [3, 1, [3, Int(v^((r - 1)/p))]], [4, 2, [4, Int(w^((s - 1)/q))]] ];
          return msg.groupFromData(data);
        end;

        if (r - 1) mod p = 0 and (s - 1) mod q = 0 then
          Add(list, data8(p, q, r, s));
        fi;

        data9 := function(p, q, r, s)
          local data;
            data := [ [p, q, r, s], [3, 2, [3, Int(v^((r - 1)/q))]], [4, 1, [4, Int(w^((s - 1)/p))]] ];
          return msg.groupFromData(data);
        end;

        if (r - 1) mod q = 0 and (s - 1) mod p = 0 then
          Add(list, data9(p, q, r, s));
        fi;

      return list;
    end;

    if ((r - 1)*(s - 1)) mod (p*q) = 0 then
      Append(all, case2(p, q, r, s));
    fi;

    ### case 3: |F| = qs, r |(s - 1), p | (q - 1)(s - 1), and G \cong C_{pr} \ltimes C_{qs}
    case3 := function(p, q, r, s)
      local data1, data2, data3_k, i, list;
        list := [];
        data1 := function(p, q, r, s)
          local data;
            data := [ [p, r, s, q], [3, 1, [3, Int(w^((s - 1)/p))]], [3, 2, [3, Int(w^((s - 1)/r))]] ];
          return msg.groupFromData(data);
        end;

        if (s - 1) mod (p*r) = 0 then
          Add(list, data1(p, q, r, s));
        fi;

        data2 := function(p, q, r, s)
          local data;
            data := [ [p, q, r, s], [2, 1, [2, Int(u^((q - 1)/p))]], [4, 3, [4, Int(w^((s - 1)/r))]] ];
          return msg.groupFromData(data);
        end;

        if (s - 1) mod r = 0 and (q - 1) mod p = 0 then
          Add(list, data2(p, q, r, s));
        fi;

        data3_k := function(k)
          local data;
            data := [ [p, r, q, s], [3, 1, [3, Int(u^(k*(q - 1)/p))]], [4, 1, [4, Int(w^((s - 1)/p))]], [4, 2, [4, Int(w^((s - 1)/r))]] ];
          return msg.groupFromData(data);
        end;

        if (q - 1) mod p = 0 and (s - 1) mod (p*r) = 0 then
          for i in [1..(p - 1)] do
            Add(list, data3_k(i));
          od;
        fi;

      return list;
    end;

    if (s - 1) mod r = 0 and ((q - 1)*(s - 1)) mod p  = 0 then
      Append(all, case3(p, q, r, s));
    fi;

    ###case 4: |F| = ps, qr | (s - 1) and G \cong (C_{qr} \ltimes C_s) \times C_p
    case4 := function(p, q, r, s)
      local data;
        data := [ [q, r, s, p], [3, 1, [3, Int(w^((s - 1)/q))]], [3, 2, [3, Int(w^((s - 1)/r))]] ];
      return msg.groupFromData(data);
    end;

    if (s - 1) mod (q*r) = 0 then
      Add(all, case4(p, q, r, s));
    fi;

    ###case 5: |F| = qrs, p | (q - 1)(r - 1)(s - 1), and G \cong C_p \ltimes C_{qrs}
    case5 := function(p, q, r, s)
      local list, data1, data2, data3, data4_k, data5_k, data6_k, data7_kl, i, j;
        list := [];

        if (q - 1) mod p = 0 then
          data1 := [ [p, q, r, s], [2, 1, [2, Int(u^((q - 1)/p))]] ];
          Add(list, msg.groupFromData(data1));
        fi;

        if (r - 1) mod p = 0 then
          data2 := [ [p, r, q, s], [2, 1, [2, Int(v^((r - 1)/p))]] ];
          Add(list, msg.groupFromData(data2));
        fi;

        if (s - 1) mod p = 0 then
          data3 := [ [p, s, q, r], [2, 1, [2, Int(w^((s - 1)/p))]] ];
          Add(list, msg.groupFromData(data3));
        fi;

        data4_k := function(k)
          local data;
            data := [ [p, q, r, s], [2, 1, [2, Int(u^(k*(q - 1)/p))]], [3, 1, [3, Int(v^((r - 1)/p))]] ];
          return msg.groupFromData(data);
        end;

        if (q - 1) mod p = 0 and (r - 1) mod p = 0 then
          for i in [1..(p - 1)] do
            Add(list, data4_k(i));
          od;
        fi;

        data5_k := function(k)
          local data;
            data := [ [p, q, s, r], [2, 1, [2, Int(u^(k*(q - 1)/p))]], [3, 1, [3, Int(w^((s - 1)/p))]] ];
          return msg.groupFromData(data);
        end;

        if (q - 1) mod p = 0 and (s - 1) mod p = 0 then
          for i in [1..(p - 1)] do
            Add(list, data5_k(i));
          od;
        fi;

        data6_k := function(k)
          local data;
            data := [ [p, r, s, q], [2, 1, [2, Int(v^(k*(r - 1)/p))]], [3, 1, [3, Int(w^((s - 1)/p))]] ];
          return msg.groupFromData(data);
        end;

        if (r - 1) mod p = 0 and (s - 1) mod p = 0 then
          for i in [1..(p - 1)] do
            Add(list, data6_k(i));
          od;
        fi;

        data7_kl := function(k, l)
          local data;
            data := [ [p, q, r, s], [2, 1, [2, Int(u^((q - 1)/p))]], [3, 1, [3, Int(v^(k*(r - 1)/p))]], [4, 1, [4, Int(w^(l*(s - 1)/p))]] ];
          return msg.groupFromData(data);
        end;

        if (q - 1) mod p = 0 and (r - 1) mod p = 0 and (s - 1) mod p = 0 then
          for i in [1..(p - 1)] do
            for j in [1..(p - 1)] do
              Add(list, data7_kl(i, j));
            od;
          od;
        fi;

      return list;
    end;

    if ((q - 1)*(r - 1)*(s - 1)) mod p = 0 then
      Append(all, case5(p, q, r, s));
    fi;

    ###case 6: |F| = prs, q | (r - 1)(s - 1), and G \cong (C_q \ltimes C_{rs}) \times C_p
    case6 := function(p, q, r, s)
      local list, data1, data2, data3_k, i;
        list := [];
        if (r - 1) mod q = 0 then
          data1 := [ [q, r, s, p], [2, 1, [2, Int(v^((r - 1)/q))]] ];
          Add(list, msg.groupFromData(data1));
        fi;

        if (s - 1) mod q = 0 then
          data2 := [ [q, r, s, p], [3, 1, [3, Int(w^((s - 1)/q))]] ];
          Add(list, msg.groupFromData(data2));
        fi;

        data3_k := function(k)
          local data;
            data := [ [q, r, s, p], [2, 1, [2, Int(v^((r - 1)/q))]], [3, 1, [3, Int(w^(k*(s - 1)/q))]] ];
          return msg.groupFromData(data);
        end;

        if (r - 1) mod q = 0 and (s - 1) mod q = 0 then
          for i in [1..(q - 1)] do
            Add(list, data3_k(i));
          od;
        fi;

      return list;
    end;

    if ((r - 1)*(s - 1)) mod q = 0 then
      Append(all, case6(p, q, r, s));
    fi;

    ###case7: |F| = pqs, r | (s - 1), and G \cong (C_r \ltimes C_s) \times C_p \times C_q
    case7 := function(p, q, r, s)
      local data;
        data := [ [r, s, p, q], [2, 1, [2, Int(w^((s - 1)/r))]] ];
      return msg.groupFromData(data);
    end;

    if (s - 1) mod r = 0 then
      Add(all, case7(p, q, r, s));
    fi;

  return all;
end;
