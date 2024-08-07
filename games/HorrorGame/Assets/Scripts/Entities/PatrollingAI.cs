using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PatrollingAI : MonoBehaviour
{
    // Радиус территории обхода
    [SerializeField] private float patrollingRadius;
    // Радиус зоны обнаружения
    [SerializeField] private float triggerRadius;
    // Радиус зоны перехода к атаке
    [SerializeField] private float attackRadius;
    // Радиус зоны коллизии с предметами
    [SerializeField] private float obstacleRange = 5.0f;
    // Начальная скорость патрулирования
    [SerializeField] private float baseSpeed = 5.0f;
    // Урон
    [SerializeField] private float damage;
    // Скорость перемещения
    public float speed = 3.0f;
    // Начальные позиции
    private float startXPosition, startYPosition;
    // Состояние: возможные значения: "PATROL", "WAITING", "WALKING", "PURSUIT", "ATTACK"
    private string state = "PATROL";
    // Таймер перехода к фазе обнаружения из фазы подготовки
    private int timer = 0;

    // Объект преследования
    /*
        * Возможна смена типа с GameObject на кастомный скрипт для учета приседа *
    */
    private GameObject hitObject;

    // Флаг жизни
    private bool _alive;




    void Start()
    {
        startXPosition = transform.position.x;
        startYPosition = transform.position.y;
        speed = baseSpeed;
    }

    
    void Update()
    {
        
    }

    // Патрулирование
    void Patrol() {
        transform.Translate(0, 0, speed * Time.deltaTime);

            Ray ray = new Ray(transform.position, transform.forward);
            RaycastHit hit;
            if (Physics.SphereCast(ray, 0.75f, out hit))
            {
                GameObject hitObject = hit.transform.gameObject;
                if (hitObject.GetComponent<PlayerCharacter>()) {
                    if(_fireball == null) {
                        _fireball = Instantiate(fireballPrefab) as GameObject;
                        _fireball.transform.position = transform.TransformPoint(Vector3.forward * 1.5f);
                        _fireball.transform.rotation = transform.rotation;
                    }
                }
                else if (hit.distance < obstacleRange) {
                    float angle = Random.Range(-110, 110);
                    transform.Rotate(0, angle, 0);
                }
            }
    }

    // Преследование
    void Pursuit() {

    }

    // Атака
    void Attach() {

    }

    // @ToDo Вынести базовый класс для монстров с общими параметрами
}
