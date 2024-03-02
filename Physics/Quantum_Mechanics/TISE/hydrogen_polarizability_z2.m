% hydrogen_polarizability_z2
% calculate \sum |<n',l',m|z|init>|^2/(E_init - E_n')

%% global
n_max = 30;
Eng = -0.5*Z^2./((1:n_max).').^2;
Z = 1;
r_max = 50;
d_mat_100 = zeros(n_max, 1);
d_mat_200 = zeros(n_max, 1);
d_mat_210 = zeros(n_max, 2);

%% <n,1,0|z|1,0,0>
d_mat_100(1) = 0;
parfor n = 2:n_max
    d_mat_100(n) = hydrogen_dipole_z(Z, n,1,0, 1,0,0, r_max);
end
rng = 2:n_max;
E2_100 = sum(abs(d_mat_100(rng)).^2 ./ (Eng(1) - Eng(rng))); % -1.8299

%% <n,1,0|z|1,0,0> continuum
mel_fun = @(k)hydrogen_trans_dipole_sph(Z, k,1,0, 1,0,0, r_max);
Nk = 101;
k = linspace(0.001, 9, Nk);
mel_100 = zeros(1, Nk);
parfor i = 1:Nk
    mel_100(i) = mel_fun(k(i));
end
figure; plot(k, mel_100);
xlabel('k'); title('<n,1,0|z|1,0,0> continuum');

dk = k(2)-k(1);
E2c_100 = (sum(abs(mel_100).^2 ./ (Eng(1)-k.^2./2)) - 0.5*abs(mel_100(1))^2/(Eng(1)-k(1)^2/2)) * dk;


%% <n,1,0|z|2,0,0>
d_mat_200(1) = 0;
parfor n = 2:n_max
    d_mat_200(n) = hydrogen_dipole_z(Z, n,1,0, 2,0,0, r_max);
end
rng = 3:n_max;
E2_200 = sum(abs(d_mat_200(rng)).^2 ./ (Eng(2) - Eng(rng))); % -55.3366

%% <n,1,0|z|2,0,0> continuum
mel_fun = @(k)hydrogen_trans_dipole_sph(Z, k,1,0, 2,0,0, r_max);
Nk = 101;
k = linspace(0.001, 6, Nk);
mel_200 = zeros(1, Nk);
parfor i = 1:Nk
    mel_200(i) = mel_fun(k(i));
end
figure; plot(k, mel_200);
xlabel('k'); title('<n,1,0|z|2,0,0> continuum');

dk = k(2)-k(1);
E2c_200 = (sum(abs(mel_200).^2 ./ (Eng(2)-k.^2./2)) - 0.5*abs(mel_200(1))^2/(Eng(2)-k(1)^2/2)) * dk;

%% <n,0,0|z|2,1,0>  <n,2,0|z|2,1,0>
parfor n = 1:n_max
    d_mat_210(n,1) = hydrogen_dipole_z(Z, n,0,0, 2,1,0, r_max);
end

d_mat_210(1:2,2) = 0;
parfor n = 3:n_max
    d_mat_210(n,2) = hydrogen_dipole_z(Z, n,2,0, 2,1,0, r_max);
end

rng = 3:n_max;
E2_210 = abs(d_mat_210(1,1)).^2 ./ (Eng(2) - Eng(1))...
       + sum(sum(abs(d_mat_210(rng,:)).^2 ./ (Eng(2) - Eng(rng)))); % -103.8213

E2_2p0 = abs(d_mat_210(1,1)/sqrt(2)).^2 ./ (Eng(2) - Eng(1))...
       + sum(sum(abs([d_mat_200(rng) d_mat_210(rng,:)]/sqrt(2)).^2 ./ (Eng(2) - Eng(rng)))); % -79.5789

E2_2m0 = abs(d_mat_210(1,1)/sqrt(2)).^2 ./ (Eng(2) - Eng(1))...
       + sum(sum(abs([d_mat_200(rng) -d_mat_210(rng,:)]/sqrt(2)).^2 ./ (Eng(2) - Eng(rng)))); % -79.5789






