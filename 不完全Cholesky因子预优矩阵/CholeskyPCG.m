 1;

% ���ɲ�����nά��������b��x0
function [A, b, x] = GenerateParameters(n)
  % ����nά����
  P = 1000 * randn(n);
  P = P' * P;
  Q = 0.01 * eye(n);
  A = P + Q;
  % ����b
  b = 1000 * randn(n, 1);
  % ����x
  x = 1000 * randn(n, 1);
endfunction

% ���ɲ���ȫCholesky����Ԥ�ž���
function M = GenerateC(A)
  A = sparse(A);
  L = ichol(A);
  M = L * L';
endfunction

% �ж�rk�Ƿ��Ѿ��㹻С
function flag = RkCheck(r, episilon, b)
  if norm(r' * r, 2) > episilon * norm(b, 2)
    flag = 1;
  else
    flag = 0;
  endif
endfunction

% ��ʼʱ��
time_0 = cputime();

% ���ɲ�����nά��������b��x0���ⷽ���飺��x
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

% �洢��ͼ��������ݣ���ӡ���յ������������
save CholeskyPCG_5000_k.csv list_k;
save CholeskyPCG_5000_error.csv list_error;
k 
error
 
% ����ʱ��
time_1 = cputime(); 
% ����ʱ���
time = time_1 - time_0