1;

% ���ɲ�����nά��������b��x0
function [A, b, x0] = GenerateParameters(n)
  % ����nά��������
  B = 1000 * randn(n);
  B = B' * B;
  C = 0.01 * eye(n);
  A = B + C;
  % ����b
  b = 1000 * randn(n, 1);
  % ����x0
  x0 = 1000 * randn(n, 1);
endfunction

% ��ʼʱ��
time_0 = cputime();

% ���ɲ�����nά��������b��x0���ⷽ���飺��x
[A, b, x0] = GenerateParameters(5000);
r0 = b - A * x0;

% ��һ�ε���
k = 1;
list_k(k) = k;
% printf("iteration times: %d\n", k);
p0 = r0;
alpha = (r0' * r0) / (p0' * A * p0);
x1 = x0 + alpha * p0;
r1 = r0 - alpha * A * p0;
error = norm(r1, 2);
list_error(k) = error;

% ������������
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

% �洢��ͼ��������ݣ���ӡ���յ������������
save CG_5000_k.csv list_k;
save CG_5000_error.csv list_error;
k
error

% ����ʱ��
time_1 = cputime(); 
% ����ʱ���
time = time_1 - time_0