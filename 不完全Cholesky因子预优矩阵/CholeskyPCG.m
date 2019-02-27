 1;

% 生成参数：n维正定矩阵，b，x0
function [A, b, x] = GenerateParameters(n)
  % 生成n维矩阵
  P = 1000 * randn(n);
  P = P' * P;
  Q = 0.01 * eye(n);
  A = P + Q;
  % 生成b
  b = 1000 * randn(n, 1);
  % 生成x
  x = 1000 * randn(n, 1);
endfunction

% 生成不完全Cholesky因子预优矩阵
function M = GenerateC(A)
  A = sparse(A);
  L = ichol(A);
  M = L * L';
endfunction

% 判断rk是否已经足够小
function flag = RkCheck(r, episilon, b)
  if norm(r' * r, 2) > episilon * norm(b, 2)
    flag = 1;
  else
    flag = 0;
  endif
endfunction

% 开始时间
time_0 = cputime();

% 生成参数：n维正定矩阵，b，x0；解方程组：求x
[A, b, x] = GenerateParameters(5000);
M = GenerateC(A);
r = b - A * x;
z = M^(-1) * r;
rho = r' * z;
p = z;
k = 0;

while(RkCheck(r, 0.0000001, b) && (k < 100))
  z = M^(-1) * r;
  k = k + 1;
  list_k(k) = k;
  % printf("iteration times: %d\n", k);
  if k == 1
    p = z;
    rho = r' * z;
  else
    rho0 = rho;
    rho = r' * z;
    beta = rho / rho0;
    p = z + (beta * p);
  endif
  w = A * p;
  alpha = rho / (p' * w);
  x = x + alpha * p;
  r = r - alpha * w;
  error = norm(r, 2);
  list_error(k) = error;
end 

% 存储绘图所需的数据，打印最终迭代次数和误差
save CholeskyPCG_5000_k.csv list_k;
save CholeskyPCG_5000_error.csv list_error;
k 
error
 
% 结束时间
time_1 = cputime(); 
% 计算时间差
time = time_1 - time_0