1;

% 生成参数：n维正定矩阵，b，x0
function [A, b, x0] = GenerateParameters(n)
  % 生成n维正定矩阵
  B = 1000 * randn(n);
  B = B' * B;
  C = 0.01 * eye(n);
  A = B + C;
  % 生成b
  b = 1000 * randn(n, 1);
  % 生成x0
  x0 = 1000 * randn(n, 1);
endfunction

% 开始时间
time_0 = cputime();

% 生成参数：n维正定矩阵，b，x0；解方程组：求x
[A, b, x0] = GenerateParameters(5000);
r0 = b - A * x0;

% 第一次迭代
k = 1;
list_k(k) = k;
% printf("iteration times: %d\n", k);
p0 = r0;
alpha = (r0' * r0) / (p0' * A * p0);
x1 = x0 + alpha * p0;
r1 = r0 - alpha * A * p0;
error = norm(r1, 2);
list_error(k) = error;

% 后续迭代步骤
while(norm(r0, 2) > 0.0000001)
  k = k + 1;
  list_k(k) = k; 
  % printf("iteration times: %d\n", k);
  beta = (r1' * r1) / (r0' * r0);
  p1 = r1 + (beta * p0);
  x0 = x1;
  r0 = r1;
  p0 = p1;
  alpha = (r1' * r1) / (p0' * A * p0);
  x1 = x0 + alpha * p0;
  r1 = r0 - (alpha * A * p0);
  error = norm(r1, 2);
  list_error(k) = error;
end 

% 存储绘图所需的数据，打印最终迭代次数和误差
save CG_5000_k.csv list_k;
save CG_5000_error.csv list_error;
k
error

% 结束时间
time_1 = cputime(); 
% 计算时间差
time = time_1 - time_0