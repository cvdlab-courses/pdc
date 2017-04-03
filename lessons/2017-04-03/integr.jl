function M(alpha, beta)
    a = 0
    for l=1:(alpha + 2)
        a += binomial(alpha+1,l) * (-1)^l/(l+beta+1)
    end
    return a/(alpha + 1)
end

function II(P, alpha, beta, gamma, signedInt=false)
    w = 0
    V, FV = P
    if typeof(P) == PyCall.PyObject
    	if typeof(V) == Array{Any,2}
    		V = V'
    	end
    	if typeof(FV) == Array{Any,2}
    		FV = [FV[k,:] for k=1:size(FV,1)]
    		FV = FV+1
    	end
    end
    if typeof(FV) == Array{Int64,2}
    	FV = [FV[:,k] for k=1:size(FV,2)]
    end
    for i=1:length(FV)
        tau = hcat([V[:,v] for v in FV[i]]...)
        if size(tau,2) == 3
        	term = TT(tau, alpha, beta, gamma, signedInt)
        	if signedInt
        		w += term
        	else
        		w += abs(term)
        	end
        elseif size(tau,2) > 3
        	println("ERROR: FV[$(i)] is not a triangle")
        else
        	println("ERROR: FV[$(i)] is degenerate")
        end
    end    
    return w
end

function III(P, alpha, beta, gamma)
    w = 0
    V, FV = P
    if typeof(P) == PyCall.PyObject
    	if typeof(V) == Array{Any,2}
    		V = V'
    	end
    	if typeof(FV) == Array{Any,2}
    		FV = [FV[k,:] for k=1:size(FV,1)]
    		FV = FV+1
    	end
    end
    if typeof(FV) == Array{Int64,2}
    	FV = [FV[:,k] for k=1:size(FV,2)]
    end
    for i=1:length(FV)
        tau = hcat([V[:,v] for v in FV[i]]...)
        vo,va,vb = tau[:,1],tau[:,2],tau[:,3]
        a = va - vo
        b = vb - vo
        c = cross(a,b)
        w += c[1]/vecnorm(c) * TT(tau, alpha+1, beta, gamma)
    end
    return w/(alpha + 1)
end

function TT(tau::Array{Float64,2}, alpha, beta, gamma, signedInt=false)
  vo,va,vb = tau[:,1],tau[:,2],tau[:,3]
  a = va - vo
  b = vb - vo
  s1 = 0.0
  for h=0:alpha
    for k=0:beta
      for m=0:gamma
        s2 = 0.0
        for i=0:h 
          s3 = 0.0
          for j=0:k
            s4 = 0.0
            for l=0:m
              s4 += binomial(m,l) * a[3]^(m-l) * b[3]^l * M( 
                h+k+m-i-j-l, i+j+l )
            end
            s3 += binomial(k,j) * a[2]^(k-j) * b[2]^j * s4
          end
          s2 += binomial(h,i) * a[1]^(h-i) * b[1]^i * s3;
        end
        s1 += binomial(alpha,h) * binomial(beta,k) * binomial(gamma,m) *       
            vo[1]^(alpha-h) * vo[2]^(beta-k) * vo[3]^(gamma-m) * s2
      end
    end
  end
  c = cross(a,b)
  if signedInt == true
    return s1 * vecnorm(c) * sign(c[3])
  else return s1 * vecnorm(c) end  
end
