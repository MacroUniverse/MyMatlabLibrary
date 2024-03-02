% hydrogen polarizability z
error('this algo is wrong, need to consider continuum, see h_polarizability_z2.m');
%% === params ===
m = 0;
n_max = 4;
Z = 1;
field_min = 0; field_max = 2e-3; Nfield = 601;
r_max = 1000;
% ==============

%% <n1,l1,m1|z|n2,l2,m2>
d_z = h_dipole_z_mat(1, m, n_max, r_max);
Ndim = size(d_z, 1);

%% energy curves
Efs = linspace(field_min, field_max, Nfield);
H0 = zeros(Ndim,Ndim);
eng = zeros(Nfield, Ndim); dipole = eng; dipole1 = eng;
k = 0;
for n = 1:n_max
    for l = 0:n-1
        k = k + 1;
        H0(k,k) = -1/(2*n^2);
    end
end

j_start = 5;
for j = 1:numel(Efs)
    Ef = Efs(j);
    H1 = Ef * d_z;
    [V,D] = Eig(H0+H1, 'ascend');
    if (j == j_start)
        V2 = V;
    end
    eng(j,:) = diag(D);
    for k = 1:Ndim % <psi|H^1|psi>
        dipole(j,k) = V(:,k)' * d_z * V(:,k);
        if (j >= j_start) % do reorder
            [~, k_new] = max(abs(V(:,k)' * V2));
            dipole1(j,k_new) = dipole(j,k);
        end
    end
end
dipole1(1:j_start, :) = dipole(1:j_start, :);

figure; plot(Efs(:), eng, 'k.-');
axis([0, 2e-3, -0.15, 0.02]);
grid on;
xlabel field; ylabel 'energy';

figure; plot(Efs(:), dipole, '-');
xlabel field; ylabel 'dipole';

figure; plot(Efs(:), dipole1, '-');
xlabel field; ylabel 'dipole';
%% calc 1st order perturbation
slopes = zeros(1, size(d_z, 1));
eng1 = zeros(size(eng));
k = 0;
for n = 1:n_max
    k1 = k+1;
    k = k + n;
    k2 = k;
    [V, D] = Eig(d_z(k1:k2, k1:k2), 'ascend');
    slopes(k1:k2) = diag(D);
    eng1(:, k1:k2) = slopes(k1:k2) .* Efs(:);
end
eng02 = eng - eng1;
figure; plot(Efs, eng02)

%% n_max = 6 de-sloped
% c1 = -1.793; % Efs(601) == 0.002
% c2 = [-80.46, -75.66]; % Efs(121) == 4e-4
% c3 = [-801.05 -843.95 -734.03] % Efs(73) == 2.4e-4

%% n_max = 10 de-sloped
% c1 = -1.818; % Efs(601) == 0.002
% c2 = [-79.98 -78.17] % Efs(121) == 4e-4
% c3 = [-815.93 -857.41 -756.48] % Efs(73) == 2.4e-4

%% n_max = 15 de-sloped
% c1 = -1.8253; % Efs(301) == 1e-3
% c2 = [-79.83 -78.94]; % Efs(61) == 2e-4
% c3 = [-799.89 -857.97 -775.94]; % Efs(31) == 1e-4

%% n_max = 15 de-sloped (hand measure, assume no avoided crossing)
% c1 = -1.8262; % Efs(601) == 2e-3
% c2 = [-83.7370 -76.5102]; % Efs([475,511]) == [1.6e-3 1.7e-3]
% c3 = [-871.42 -1048.1 -699.55]; % Efs(481) == 1.6e-3
