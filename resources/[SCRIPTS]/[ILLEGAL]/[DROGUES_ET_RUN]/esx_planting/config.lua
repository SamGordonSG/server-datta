Config = {}
Config.Locale = "en"
--You can add here buttons like inventory menu button. When player click this button, then action will be cancel.
Config.cancel_buttons = {289, 170, 168, 56}

options =
{
  ['seed_weed'] = {
        object = 'prop_weed_01',
        end_object = 'prop_weed_02',
        fail_msg = 'Malheureusement, votre plante est flétrie!',
        success_msg = 'Félicitations, vous avez récolté la plante!',
        start_msg = 'Commencer à faire pousser des plantes.',
        success_item = 'weed',
        cops = 0,
        first_step = 2.35,
        steps = 7,
        cords = {
          {x = -427.05, y = 1575.25, z = 357, distance = 20.25},
          {x = 2213.05, y = 5576.25, z = 53, distance = 10.25},
          {x = 1198.05, y = -215.25, z = 55, distance = 20.25},
          {x = 706.05, y = 1269.25, z = 358, distance = 10.25},
        },
        animations_start = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim = 'enter', timeout = '2500'},
          {lib = 'amb@world_human_gardener_plant@male@idle_a', anim = 'idle_a', timeout = '2500'},
        },
        animations_end = {
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '2500'},
          {lib = 'amb@world_human_cop_idles@male@idle_a', anim ='idle_a', timeout = '2500'},
        },
        animations_step = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim = 'enter', timeout = '2500'},
          {lib = 'amb@world_human_gardener_plant@male@idle_a', anim ='idle_a', timeout = '18500'},
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '2500'},
        },
        grow = {
          2.24, 1.95, 1.65, 1.45, 1.20, 1.00
        },
        questions = {
            {
                title = 'Vous voyez votre plante germer, que faites-vous?',
                steps = {
                    {label = 'J arrose la plante', value = 1},
                    {label = 'Je féconde la plante', value = 2},
                    {label = 'J attends', value = 3}
                },
                correct = 1
            },
            {
                title = 'Des points jaunes sont apparus sur votre plante, que faites-vous?',
                steps = {
                    {label = 'J arrose la plante', value = 1},
                    {label = 'Je féconde la plante', value = 2},
                    {label = 'J attends', value = 3}
                },
                correct = 2
            },
            {
                title = 'De la poussière bleue est apparue sur les feuilles de votre plante, que faites-vous?',
                steps = {
                    {label = 'Je cueille des feuilles individuelles', value = 1},
                    {label = 'Saupoudrer les feuilles d engrais', value = 2},
                    {label = 'J attends', value = 3}
                },
                correct = 3
            },
            {
                title = 'Votre plante commence a pousser, que faites-vous??',
                steps = {
                    {label = 'J arrose la plante', value = 1},
                    {label = 'Je les casse tout de suite', value = 2},
                    {label = 'Je féconde la plante', value = 3}
                },
                correct = 1
            },
            {
                title = 'Après avoir arrosé votre plante, d étranges feuilles ont commencé à apparaître, que faites-vous?',
                steps = {
                    {label = 'J arrose la plante', value = 1},
                    {label = 'Je féconde la plante', value = 2},
                    {label = 'J attends', value = 3}
                },
                correct = 2
            },
            {
                title = 'Votre plante est presque prête à être coupée, que faites-vous?',
                steps = {
                    {label = 'J arrose la plante', value = 1},
                    {label = 'Je féconde la plante', value = 2},
                    {label = 'J attends', value = 3}
                },
                correct = 1
            },
            {
                title = 'Votre plante est prête pour la récolte, que faites-vous?',
                steps = {
                    {label = 'Recueillir à l aide de ciseaux', value = 1, min = 5, max = 25},
                    {label = 'Récolter à la main', value = 1, min = 10, max = 15},
                    {label = 'Récolter au sécateur', value = 1, min = 2, max = 40}
                },
                correct = 1
            },
        },
      },
}
