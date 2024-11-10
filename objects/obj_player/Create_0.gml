walk_speed = 30;
jump_speed = -15;

horizontal_speed = 0;
max_horizontal_speed = 5;

vertical_speed = 0;
max_vertical_speed = 20;

ground = false;

life = 100;

takes_damage = false;


#region // Inicializa as variáveis de controle
function initialize_controls() {
    global.key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
    global.key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
    global.key_jump = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
    global.key_fall = keyboard_check_released(vk_up) || keyboard_check_released(ord("W"));
    global.key_attack = keyboard_check(vk_space);
	global.key_run = keyboard_check(vk_shift);

}
#endregion

#region // Aplica o movimento com base nas teclas de controle
function apply_movement() {
    // Atualiza as variáveis de controle
    initialize_controls();

    // Movimentos horizontais
    if (global.key_right) {
        horizontal_speed = max_horizontal_speed;
    }

    if (global.key_left) {
        horizontal_speed = -max_horizontal_speed;
    }

    if (!global.key_right && !global.key_left) {
        horizontal_speed = 0;
    }

    // Verifica colisão com o bloco sólido
    if (place_meeting(x + horizontal_speed, y, obj_solid_block)) {
        horizontal_speed = 0;
    } else {
        x += horizontal_speed;
    }
}
#endregion

#region // Verifica se o personagem está no chão

function check_ground_status() {
    return place_meeting(x, y + 1, obj_solid_block);
}

// Função para aplicar o movimento vertical e o salto
function apply_vertical_movement() {
    
	// Verifica o estado do chão
    ground = check_ground_status();

    // Aplicação da gravidade
    if (!global.key_jump && !ground) {
        vertical_speed++;
    } else {
        vertical_speed = 0;
    }

    // Inicia o salto
    if (global.key_jump && ground) {
        vertical_speed = jump_speed;
    }

    // Verifica colisão com o bloco sólido ao cair
    if (place_meeting(x, y + vertical_speed, obj_solid_block)) {
        while (!place_meeting(x, y + 1, obj_solid_block)) {
            y += 1;
        }
        ground = true;
        vertical_speed = 0;
    }

    // Aplica o movimento vertical
    y += vertical_speed;
}
#endregion